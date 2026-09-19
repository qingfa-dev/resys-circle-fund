# Synchronization Design — Integrity, Recovery & Testing

## Integrity Checks

On app start and after sync:
1. Verify queue integrity (no corrupt entries).
2. Compare local cache timestamps vs server.
3. Verify every pending op has a valid `idempotencyKey` and `localId`.
4. Detect orphaned local records (no corresponding op).

## Recovery Scenarios

| Scenario | Recovery |
| --- | --- |
| App crash mid-sync | op stays `syncing`; replayed on next start |
| Network failure mid-sync | `failed→pending`, retry with backoff |
| Server restart during sync | replayed on reconnect |
| Local data corruption | rebuild local state from server (re-sync) |
| Duplicate operation | server returns cached result (idempotency) |
| LocalId collides with server ID | detected and remapped (client → serverRecordId) |

## Testing (I1/I2 CI)

- Two devices queue conflicting edits to the same share → resolved, not silently dropped.
- Two devices queue conflicting financial mutations → flagged for manual reconciliation.
- Device goes offline mid-operation, reconnects after a delay → operation completes exactly once.
- Local ID collides with a since-created server ID → detected and remapped.

## Failure Modes & Guarantees

| Guarantee | Mechanism |
| --- | --- |
| Exactly-once | idempotency keys (server) |
| Ordering | FIFO by `createdAt` |
| No silent discard | conflict surfaced |
| No data loss | persistent queue + integrity checks |
| Authoritative truth | server, not client |