# Data Model — Constraints & Migration

## Integrity Constraints

- **NOT NULL** on all key/business fields.
- **FOREIGN KEY** on all relationships (EF Core + DB enforcement).
- **UNIQUE** where duplicates are illegal:

| Table | Unique columns |
| --- | --- |
| AspNetUsers | (UserName), (Email) |
| Periods(Rounds) | (CircleId, RoundNumber), (CircleId, ScheduledDate) |
| CircleMembers | (CircleId, UserId) |
| CircleShares | (CircleId, ShareNumber) |
| Contributions | (CircleId, RoundId, MemberId, ShareId), (IdempotencyKey) |
| Payouts | (CircleId, RoundId, RecipientId) |
| LocalOperations | (IdempotencyKey) |
| SyncStatus | (RecordType, RecordId) |
| ExternalIdentities | (Provider, ExternalSubject) |

- **CHECK** constraints:

| Table | Constraint |
| --- | --- |
| Rounds | `RoundNumber > 0` |
| Contributions | `Amount > 0` |
| Bids | `Amount > 0` |
| Payouts | `GrossAmount > 0`, `NetAmount <= GrossAmount` |
| LedgerEntries | `Amount <> 0` |

- **Optimistic concurrency:** `RowVersion` on financial aggregates (Circles, Rounds, Contributions, Payouts).

## Indexes

| Table | Index |
| --- | --- |
| Contributions | (CircleId, MemberId, RoundId, Status); (IdempotencyKey) |
| CircleShares | (CircleId, MemberId) |
| LedgerEntries | (CircleId, CreatedAt); (CircleId, MemberId, CreatedAt); (ReferenceType, ReferenceId) |
| AuditRecords | (ResourceType, ResourceId); (ActorId, Timestamp); (CorrelationId) |
| Bids | (CircleId, RoundId, MemberId) |
| LocalOperations | (CircleId, Status) |

## Migration Strategy

- EF Core migrations; reversible; tested on clean + existing DB + rollback.
- Sync status/local-operation tracking introduced in Iteration 1, not retrofitted.
- `CREATE INDEX CONCURRENTLY` on large tables.
- Seed/reference data (Association Types) via idempotent migrations.

See `docs/10-maintenance/migration-policy/`.