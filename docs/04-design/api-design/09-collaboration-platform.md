# API Design — Collaboration (I4) & Platform (I5)

## Collaboration (I4)

| Domain | Endpoints (illustrative) |
| --- | --- |
| Groups | `POST/GET /groups`, `GET/PUT /groups/{id}`, `POST /groups/{id}/invitations`, `POST /invitations/{id}/accept|reject` |
| Roles | `PUT /groups/{id}/members/{memberId}/role` |
| Announcements | `POST/GET /groups/{id}/announcements` |
| Voting | `POST/GET /groups/{id}/votes`, `POST /votes/{id}/cast`, `POST /votes/{id}/close` |
| Rules / Fines | `POST/GET /groups/{id}/rules`, `POST/GET /groups/{id}/fines`, `POST /fines/{id}/appeals` |
| Chat / Meetings / Tasks | `POST/GET /groups/{id}/messages`, `.../meetings`, `.../tasks` |

## Platform (I5)

| Domain | Endpoints (illustrative) |
| --- | --- |
| Accounts / Transfers | `POST/GET /accounts`, `POST /transfers` (Idempotency-Key) |
| Budgets / Invoices | `POST/GET /budgets`, `POST/GET /invoices` |
| Documents | `POST /documents`, `GET /documents/{id}`, `POST /documents/{id}/versions` |
| Calendar | `GET /calendar`, `POST/GET /events` |
| Import / Export | `POST /imports`, `POST /imports/{id}/confirm`, `POST /exports` |
| Community | `POST/GET /posts`, `POST /posts/{id}/moderate` |

All follow `01-conventions.md` (REST, pagination, error envelope). Financial mutations (transfers) require idempotency keys.