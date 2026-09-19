# ADR-002: Synchronization Strategy

## Status

Deferred (Phase 4)

## Context

When offline operation is introduced (Phase 4), the system needs a reliable strategy for synchronizing local changes with the server. Financial data requires stronger guarantees than typical sync scenarios:

- No financial data can be silently lost
- No financial transaction can be duplicated
- The server must remain the authoritative source
- Users must be able to detect and resolve conflicts

## Decision

### Server-Authoritative Model

The server is the single source of truth for all financial records. The client maintains a read cache that can be used offline but is never authoritative.

### Synchronization Pattern: Queue-and-Replay

1. **Client creates operation** → generates a unique operation key (UUIDv4)
2. **Client stores operation locally** → in a sync queue with status `pending`
3. **Connectivity returns** → sync engine processes queue in FIFO order
4. **Each operation sent to server** → with operation key in request header
5. **Server processes idempotently** → uses operation key to detect duplicates
6. **Server returns result** → with authoritative data
7. **Client updates local state** → based on server response
8. **Sync queue entry marked** → as `synced` or `conflict`

### Conflict Detection

Conflicts occur when:

- A record was modified locally AND on the server since last sync
- A dependent record was changed (e.g., period closed locally but server has different state)
- Server rejects an operation due to business rule violation that wasn't checked locally

### Conflict Resolution Strategy

| Conflict Type | Resolution |
|---------------|-----------|
| Record modified both sides | User notified, show both versions, user chooses |
| Server rejects operation | Show server error, preserve local copy |
| Period state changed | Discard local write, show updated state |
| Balance changed by other operations | Recalculate locally from server ledger |

### Idempotency at Server

Each financial mutation endpoint accepts an `Idempotency-Key` header:

- If key exists in server store → return stored result (HTTP 200 with cached response)
- If key is new → process request, store result, return response
- Key retention: configurable (default 24 hours)
- Key is scoped per-circle per-user to prevent cross-circle confusion

### Data Flow

```text
Offline Operation
      ↓
Local Sync Queue (pending)
      ↓
Connectivity Restored
      ↓
Send to Server (with Idempotency-Key)
      ↓
┌─── Server Receives ┌───────────────────────────┐
│                    │                            │
│  Key exists?       │  Key is new?               │
│  YES               │  YES                       │
│  ↓                 │  ↓                         │
│  Return cached     │  Process request           │
│  result            │  ↓                         │
│  (HTTP 200)        │  Store result              │
│                    │  ↓                         │
│                    │  Return result             │
│                    │  (HTTP 200)                │
└────────────────────┴────────────────────────────┘
      ↓
Client Receives Response
      ↓
Update Local State
      ↓
Mark Sync Queue Entry as Synced
```

## Consequences

### Positive

- No duplicate financial operations even with retries
- Users can work offline for supported operations
- Server remains authoritative for all financial decisions
- Clear conflict detection and resolution paths

### Negative

- Increased client complexity (sync queue, local storage, conflict UI)
- Sync operations may fail (network errors, server rejects)
- Users must understand that some operations require connectivity
- Testing matrix expands significantly

### Risks

- Sync queue data loss on client device (mitigated by persistent storage)
- Complex conflict resolution may frustrate users
- Out-of-order delivery if sync queue not strictly FIFO

## Mitigations

- Sync queue stored in IndexedDB with integrity verification
- FIFO processing guarantees order
- Health check before sync to verify connectivity
- Batch sync for multiple pending operations
- Clear visual indication of sync status (pending, synced, conflict)
- Automatic retry with exponential backoff for transient failures
- Manual retry option for permanent failures
- Sync status indicator in the UI
