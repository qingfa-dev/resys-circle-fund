# Synchronization Design — Offline Queue

## Data Structure

```typescript
interface Operation {
  localId: string            // UUIDv4, client-generated (unique)
  idempotencyKey: string     // UUIDv4, exactly-once replay
  type: 'Contribution' | 'PayoutDraw' | 'Bid' | ...
  circleId: string
  payload: unknown           // captured request body
  status: 'pending' | 'syncing' | 'synced' | 'conflict' | 'failed' | 'cancelled'
  retryCount: number
  lastError?: string
  serverRecordId?: string    // authoritative id after successful sync
  createdAt: string          // ISO 8601
}
```

## Storage

- IndexedDB (web) / SQLite (native PWA).
- Keys: `localId` primary; `idempotencyKey` unique; index on `(circleId, status)`.
- Integrity check on app start (detect corrupt entries).

## Enqueue (write path)

```typescript
async function enqueue(input: ContributionInput): Promise<Operation> {
  const op: Operation = {
    localId: crypto.randomUUID(),
    idempotencyKey: crypto.randomUUID(),
    type: 'Contribution',
    circleId: input.circleId,
    payload: input,
    status: 'pending',
    retryCount: 0,
    createdAt: new Date().toISOString(),
  }
  await db.operations.add(op)
  return op
}
```

## Status Transitions

```text
pending → syncing → synced
pending → syncing → conflict      (needs user resolution)
pending → syncing → failed → pending   (retry w/ backoff, retryCount < MAX)
* → cancelled                     (user cancels)
```

`MAX` retries = 5; backoff = exponential (1s, 2s, 4s, 8s, 16s) with jitter.