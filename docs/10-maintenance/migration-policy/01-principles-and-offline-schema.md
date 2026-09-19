# Migration Policy — Principles & Offline Schema

**Index:** `docs/10-maintenance/migration-policy.md`

## Principles

1. **Reversible** — every migration has a rollback (or a documented limitation).
2. **Backward-compatible where possible** — safe patterns (add nullable column, new table, new index, seed row) over risky (rename/drop column, type change, drop table).
3. **Safe for production** — no table locks on large tables; `CREATE INDEX CONCURRENTLY`; test on realistic volumes.

## Offline-First Schema

- Local operations + per-record sync status reflect FR-I1-041..045.
- Financial tables add `sync_status` (`pending/synced/conflict`) feeding FR-I2-049.
- `sync_status` added as nullable with default `synced` (existing rows remain valid).
- Introduced in Iteration 1, never retrofitted.

## Safe vs Risky

| Safe | Risky |
| --- | --- |
| add nullable column | rename column |
| add table / index | change column type |
| add seed row | drop column/table |
| | unbounded data rewrite |