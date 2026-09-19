# Implementation Notes — Financial, Concurrency, Integration

**Index:** `docs/05-development/implementation-notes.md`

## Financial Operation Pattern
Idempotency check → domain validation → domain logic → single transaction (entity + balance + ledger + audit + outbox) → store idempotency result. Atomic (NFR-004); corrections compensating (ADR-003).

## Balance Derivation

```csharp
public decimal GetMemberBalance(Guid memberId, Guid circleId) =>
    _db.LedgerEntries.Where(e => e.MemberId == memberId && e.CircleId == circleId)
                     .Sum(e => e.Amount);
```

## Concurrency & Idempotency
Optimistic concurrency via `RowVersion`; on conflict reload/re-apply/retry. Unique constraints back idempotency (idempotency key, one contribution per member/share/round).

## Integration Degradation (I3)
External calls are best-effort (publish), never thrown into the commit path. AI: interpret → propose → confirm → commit.

## Config & Background Jobs
`appsettings.json`→`{Environment}`→env vars; secrets via user-secrets/Vault. Background jobs (reports/exports/imports/backups) have retry/idempotency/status/monitoring (NFR-033); never block HTTP.