# Implementation Notes — Offline Queue & Sync Engine

**Index:** `docs/05-development/implementation-notes.md`

## Local Operation Queue

```typescript
interface Operation {
  localId: string; idempotencyKey: string;
  type: 'Contribution' | 'PayoutDraw' | 'Bid' | …;
  circleId: string; payload: unknown;
  status: 'pending' | 'syncing' | 'synced' | 'conflict' | 'failed';
  retryCount: number; createdAt: string;
}
```

## Sync Engine (exactly-once)

```typescript
async function replayQueue() {
  for (const op of await queue.pending()) {       // FIFO
    op.status = 'syncing'
    try { const res = await api.post('/sync/batch', { idempotencyKey: op.idempotencyKey, type: op.type, payload: op.payload })
          op.status = 'synced'; applyServerState(res.data) }
    catch (e) {
      if (isConflict(e)) { op.status = 'conflict'; notifyConflict(op) }
      else if (isTransient(e)) { op.status = 'pending'; scheduleRetry(op) }
      else { op.status = 'failed'; op.lastError = e.message } }
  }
}
```

## Pending-Sync Authoritative Guard (FR-I2-049)

```csharp
var authoritative = dbContext.Contributions
    .Where(c => c.SyncStatus != SyncStatus.PendingSync && c.SyncStatus != SyncStatus.Conflict);
```