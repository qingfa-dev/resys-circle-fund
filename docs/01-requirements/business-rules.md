# Business Rules — Index

Business rules are decomposed by category under `business-rules/`:

| File | Category |
| --- | --- |
| `01-circle.md` | Circle rules (BR-CIR-001 to 005) |
| `02-member-and-share.md` | Member & Share rules (BR-MEM-001 to 004) |
| `03-contribution.md` | Contribution rules (BR-CON-001 to 005) |
| `04-payout-and-bidding.md` | Payout Draw & Bidding rules (BR-PAY-001 to 003, BR-BID-001 to 004) |
| `05-financial.md` | Financial rules (BR-FIN-001 to 007) |
| `06-offline-and-sync.md` | Offline & Synchronization rules (BR-SYN-001 to 004) |
| `07-reconciliation-and-audit.md` | Reconciliation & Audit rules (BR-REC-001 to 002, BR-AUD-001 to 002) |
| `08-integration.md` | Integration degradation rules (BR-INT-001 to 003) |

These rules are the authoritative domain invariants enforced by the application regardless of UI or implementation. They trace to the FR/NFR they govern (see `requirements-traceability.md`).