# Data Model — Index

The data model is decomposed under `data-model/`:

| File | Content |
| --- | --- |
| `01-core-tables.md` | Users, Circles, Rounds, Members, Shares, Contributions, Bids, Payouts, Ledger, Audit, Notifications |
| `02-offline-sync-tables.md` | LocalOperations, SyncStatus (local ID, per-record sync marker) |
| `03-integration-tables.md` | Files, ExternalIdentities, Subscriptions, Backups |
| `04-constraints-and-migration.md` | Integrity constraints, indexes, migration policy |

Money uses fixed-precision `numeric(18,2)`; financial tables are append-oriented and audit-tracked (create/by + correlation). Sync fields are introduced in Iteration 1.