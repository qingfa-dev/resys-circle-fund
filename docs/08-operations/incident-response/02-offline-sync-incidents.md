# Incident Response — Offline/Sync Incidents

## Sync Conflict Storm
1. Detect rising `conflict` counts.
2. Pause automatic sync (no auto-merge for financial records).
3. Surface conflicts for user resolution.
4. Investigate root cause (schema change, clock skew, ID collision).
5. Restore sync after verification.

## Pending-Sync Backlog
1. Detect unbounded pending-sync growth.
2. Check connectivity/endpoint failure.
3. Verify idempotency (no duplicates on replay).
4. Resume sync in FIFO order.

## Local-ID Collision
Re-map colliding local IDs (FR-I1-041, TC-I1-055) and verify no data was attributed to the wrong record.