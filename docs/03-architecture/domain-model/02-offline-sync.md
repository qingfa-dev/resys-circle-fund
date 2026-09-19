# Domain Model — Offline & Synchronization

**Subdomain:** Offline & Synchronization · Iteration 1 (foundational)

## Local Operation Queue

### Operation (aggregate)

**Attributes:** `LocalId` (UUID, client-generated, unique), `IdempotencyKey` (UUID), `Type` (Contribution | PayoutDraw | Bid | …), `Payload` (jsonb), `CircleId` (scope), `Status`, `RetryCount`, `LastError`, `CreatedAt`.

**Status state machine:**

```text
pending → syncing → synced
pending → syncing → conflict     (user resolution)
pending → syncing → failed → pending   (retry with backoff)
pending/syncing/failed → cancelled     (user cancel)
```

**Transitions:**
- `pending → syncing` — dequeued (FIFO).
- `syncing → synced` — server committed; client applies authoritative result.
- `syncing → conflict` — server detected a conflicting change (financial → manual reconciliation only).
- `syncing → failed` — non-conflict error (transient; retryable; or permanent after limit).
- `failed → pending` — retry scheduled with exponential backoff.

### SyncStatus (per-record marker)

**Attributes:** `RecordType`, `RecordId`, `Status` (PendingSync | Synced | Conflict), `ServerVersion` (rowversion/timestamptz for optimistic concurrency).

**Rules:**
- Every financial record exposes sync status in the UI (FR-I1-045).
- Pending-sync/conlict records are excluded from authoritative balance/ledger/report reads (FR-I2-049).

## Invariants

- Offline operations carry unique local IDs (BR-SYN-001, FR-I1-041).
- Sync replays exactly-once (idempotency keys) (BR-SYN-004).
- Conflicts surface both versions; never auto-merged (BR-SYN-002, FR-I1-044).
- Financial-mutation conflicts escalate to manual reconciliation (FR-I2-048).

## Domain Events

`OperationQueued`, `OperationSyncing`, `OperationSynced`, `SyncConflictDetected`, `SyncConflictResolved`.