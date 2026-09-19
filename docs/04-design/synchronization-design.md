# Synchronization Design — Index

Offline capture and synchronization (foundational, Iteration 1). Decomposed under `synchronization-design/`:

| File | Content |
| --- | --- |
| `01-principles.md` | Server-authoritative, local-first, idempotent, FIFO, no silent discard |
| `02-offline-queue.md` | Local operation queue structure |
| `03-sync-flow.md` | FIFO replay, exactly-once, conflict check |
| `04-conflict-resolution.md` | Conflict UX + financial escalation |
| `05-read-cache-and-status.md` | Read cache + sync status indicator |
| `06-integrity-recovery-testing.md` | Recovery scenarios + I1/I2 test coverage |

See ADRs: `docs/03-architecture/adr/ADR-001-offline-first.md`, `ADR-002-sync-strategy.md`.