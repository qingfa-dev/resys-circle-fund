# Domain Model — Index

The domain model is decomposed by subdomain under `domain-model/`:

| File | Subdomain | Iteration |
| --- | --- | --- |
| `01-core-rosca.md` | Savings Circle (ROSCA) aggregate | 1–2 |
| `02-offline-sync.md` | Offline & Synchronization | 1 (foundational) |
| `03-integrations.md` | Notification, File, IdP, AI, Analytics, Subscription, Backup | 3 |
| `04-collaboration.md` | Group, Roles, Voting, Rules, Fines, Chat, Meetings, Tasks | 4 |
| `05-platform.md` | Accounts, Transfers, Budgets, Invoices, Documents, Calendar, Import/Export, Sharing, Community | 5 |
| `06-cross-cutting-and-events.md` | Money, Balance, Idempotency, Correlation, Compensating transactions, Domain events | all |

Domain concepts map to the functional requirements in `docs/01-requirements/fr/` and invariants in `docs/01-requirements/business-rules/`.