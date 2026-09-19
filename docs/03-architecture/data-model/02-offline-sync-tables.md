# Data Model — Offline & Sync Tables (column-level)

Iteration 1 → 2 (foundational).

## LocalOperations (client queue origin; not authoritative until sync)

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| LocalId | uuid | N | PK, client-generated |
| IdempotencyKey | uuid | N | UNIQUE — exactly-once replay |
| Type | text | N | Contribution / PayoutDraw / Bid / … |
| Payload | jsonb | N | captured request |
| CircleId | uuid | N | scope |
| Status | int | N | pending/syncing/synced/conflict/failed/cancelled |
| RetryCount | int | N | default 0 |
| LastError | text | Y | |
| ServerRecordId | uuid | Y | authoritative id after sync |
| CreatedAt | timestamptz | N | |

Index (CircleId, Status); index (IdempotencyKey unique).

## SyncStatus (per-record marker)

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| RecordType | text | N | entity type |
| RecordId | uuid | N | |
| Status | int | N | PendingSync/Synced/Conflict |
| ServerVersion | timestamptz | Y | optimistic-concurrency token |
| UpdatedAt | timestamptz | N | |

UNIQUE (RecordType, RecordId).

## Migration Note

`sync_status` on financial tables is introduced as a nullable column defaulting to `synced` (so existing rows remain valid). See `docs/10-maintenance/migration-policy/`.