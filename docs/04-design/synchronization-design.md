# Synchronization Design — CircleFund

## Overview

This document describes the synchronization design for offline-capable operations, progressive from Phase 4 onwards.

## Principles

1. **Server-authoritative:** The server always has the final truth for financial records
2. **Progressive adoption:** Offline support is rolled out feature by feature
3. **Idempotent operations:** All sync operations can be safely retried
4. **FIFO queue:** Operations are synchronized in the order they were created
5. **Graceful degradation:** When sync fails, the user is informed with clear options

## Offline Queue

### Queue Structure

```text
SyncQueue
├── Operation 1
│   ├── OperationId (UUIDv4)
│   ├── Type (Contribution, Payout, etc.)
│   ├── Payload (request data)
│   ├── CreatedAt (timestamp)
│   ├── Status (pending, syncing, synced, conflict, failed)
│   ├── RetryCount (integer)
│   ├── LastError (string, nullable)
│   └── CircleId (for scoping)
│
├── Operation 2
│   └── ...
│
└── Operation N
    └── ...
```

### Queue States

```text
pending → syncing → synced
pending → syncing → failed → pending (retry allowed)
pending → syncing → conflict (manual resolution)
pending → cancelled (user cancelled)
```

## Sync Engine Flow

```text
Connectivity Detected
      ↓
Check Sync Queue
      ↓
┌─── Queue Empty? ───┐
│                    │
YES                  NO
│                    │
│                    ▼
│            Dequeue next operation
│                    │
│                    ▼
│            Mark as "syncing"
│                    │
│                    ▼
│            POST to server
│            (with Idempotency-Key)
│                    │
│            ┌───────┴───────┐
│            │               │
│        Success          Failure
│            │               │
│            ▼               ▼
│        Mark synced     Check error type
│        Update local     │
│        state            ├── Network error?
│            │            │     YES → retry (backoff)
│            │            │     NO  → check below
│            │            │
│            │            ├── Conflict?
│            │            │     YES → Mark conflict
│            │            │           Notify user
│            │            │
│            │            └── Server error?
│            │                  YES → Mark failed
│            │                       Allow retry
│            │
│            ▼
│        Process next operation
│        (loop back to "Check Sync Queue")
│
└─── Show online indicator ──→ End
```

## Conflict Resolution UI

When a conflict is detected:

1. **Show the conflict** to the user with details
2. **Show server version** and local version side by side
3. **Present options:**
   - Accept server version (discard local)
   - Keep local version (retry with conflict resolution)
   - Cancel (keep both, decide later)
4. **Record resolution** in audit trail

## Sync Status Indicator

The UI shows sync status:

| Icon | Meaning |
|------|---------|
| 🌐 Online, synced | All operations synchronized |
| ⏳ Online, pending | Operations waiting to sync |
| 🔄 Syncing | Currently synchronizing |
| ⚠️ Conflict | Conflict detected |
| ✖️ Offline | No connectivity |

## Read-Only Cache

For offline reading, the frontend caches:

### Cacheable Data

- Circle summary (name, status, member count)
- Member list (name, status, share count)
- Period list (number, date, status)
- Contribution history (last 10 per member)
- Current balances

### Cache Strategy

- Cache stored in IndexedDB
- Cache keyed by circle ID + timestamp
- Cache invalidated on successful sync
- Cache age displayed to user (e.g., "Data: 2 hours old")

## Data Integrity

### Integrity Checks

On app start and after sync:

1. Verify sync queue integrity
2. Compare local cache timestamps with server
3. Verify all pending operations have idempotency keys
4. Check for orphaned local records

### Recovery Scenarios

| Scenario | Recovery |
|----------|----------|
| App crash during sync | Operation remains in "syncing" state, retried on next start |
| Network failure mid-sync | Operation retried with backoff |
| Server restart during sync | Client retries after connection restored |
| Data corruption | Re-sync from server, rebuild local state |
| Duplicate operation | Server returns cached result (idempotency) |

## Background Sync

When the app is running but the user is on another screen:

1. Background service checks connectivity periodically
2. If connected and pending operations exist, sync automatically
3. Notifications alert user if conflicts or failures occur
4. Browser PWA background sync API is used where supported
