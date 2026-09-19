# API Design — Offline & Sync

## Endpoints

| Method | Endpoint | Purpose |
| --- | --- | --- |
| POST | `/sync/batch` | replay one queued operation (Idempotency-Key) |
| GET | `/sync/status?circleId=&since=` | query sync state |
| GET | `/records/{type}/{id}/sync-status` | per-record sync marker |
| POST | `/sync/conflicts/{id}/resolve` | resolve a conflict |

## Batch Request/Response

```http
POST /api/v1/sync/batch
{ "idempotencyKey": "...", "type": "Contribution", "circleId": "...",
  "payload": {...}, "clientCreatedAt": "..." }
```

```json
// 200 success
{ "data": { "id": "<serverRecordId>" } }
// 409 conflict
{ "error": { "code": "SYNC_CONFLICT",
  "details": { "localVersion": {...}, "serverVersion": {...} } } }
```

## Behavior
- FIFO, exactly-once (idempotency).
- Pending-sync records are excluded from authoritative balance/ledger/report reads (FR-I2-049).
- Financial-mutation conflicts require manual resolution (FR-I2-048).

See `docs/04-design/synchronization-design/` for the full algorithm.