# Synchronization Design — Sync Flow

## Pseudocode

```typescript
async function syncEngine() {
  if (!navigator.onLine) return
  const queue = await db.operations
    .where('status').anyOf('pending', 'failed')
    .filter(o => o.retryCount < MAX)
    .orderBy('createdAt')          // FIFO
    .toArray()

  for (const op of queue) {
    op.status = 'syncing'
    await db.operations.put(op)
    try {
      const res = await api.post('/sync/batch', {
        idempotencyKey: op.idempotencyKey,
        type: op.type,
        circleId: op.circleId,
        payload: op.payload,
        clientCreatedAt: op.createdAt,
      })
      op.status = 'synced'
      op.serverRecordId = res.data.id
      applyServerState(res.data)   // authoritative result
      await db.operations.put(op)
    } catch (e) {
      if (isConflict(e)) {         // HTTP 409 SYNC_CONFLICT
        op.status = 'conflict'
        await db.operations.put(op)
        notifyConflict(op)
      } else if (isTransient(e)) { // network/5xx/timeout
        op.status = 'pending'
        op.retryCount += 1
        op.lastError = e.message
        await db.operations.put(op)
        scheduleRetry(op, backoff(op.retryCount))
      } else {                     // permanent (4xx business rule)
        op.status = 'failed'
        op.lastError = e.message
        await db.operations.put(op)
      }
    }
  }
}
```

## Trigger Points

- On `online` event.
- On app foreground/start.
- On a periodic timer (e.g., 30s) while offline items remain.
- After a user manually taps "Sync now".

## Batch Endpoint

`POST /sync/batch` processes one operation; idempotency is per-operation key.

```http
POST /api/v1/sync/batch
{ "idempotencyKey": "...", "type": "Contribution", "circleId": "...",
  "payload": {...}, "clientCreatedAt": "..." }
```

Responses: `200 {data}` on success; `409 SYNC_CONFLICT` with `{data:{serverVersion, localVersion}}` on conflict.

## Exactly-Once Guarantee

The server stores `idempotencyKey → result`; a re-sent operation returns the cached result without re-applying (ADR-004). Client re-attempts are therefore safe.