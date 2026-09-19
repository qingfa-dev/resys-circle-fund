# Migration Policy — Process, Testing & Rollback

**Index:** `docs/10-maintenance/migration-policy.md`

## Process

```bash
dotnet ef migrations add <Name> --project CircleFund.Infrastructure
dotnet ef migrations script --project CircleFund.Infrastructure   # review SQL
```

## Testing
Every migration tested on clean DB, existing DB, and rollback. Checklist: applies cleanly; seed loads; rollback executes; app works; tests pass; performance acceptable; no data loss.

## Deployment & Rollback
Backward-compatible: deploy code → migrate → deploy feature code. Breaking: compatibility layer → migrate → new code → later remove layer. Failed migration: stop → rollback → verify → fix → retry. Corruption: restore (backup-recovery).

## Safety Rules & Seed Data
Never without preparation: drop columns, change types on large tables, unbounded ops, remove constraints, delete data. Seed data (e.g., Association Types) is migration-based, idempotent, version-controlled.