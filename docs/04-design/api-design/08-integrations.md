# API Design — Integrations (Iteration 3)

| Domain | Endpoints |
| --- | --- |
| Notifications | `GET/PUT /users/me/notification-preferences` |
| Files | `POST /files`, `GET /files/{id}`, `POST /files/{id}/versions` |
| External IdP | `POST /auth/external/{provider}`, `DELETE /users/me/external-identities/{id}` |
| AI Entry | `POST /ai/interpret`, `POST /ai/confirm` |
| Analytics | `GET /analytics/collections` |
| Subscription | `GET /subscriptions/plans`, `POST /subscriptions` |
| Backup | `POST /backups`, `GET /backups`, `POST /backups/{id}/restore` |

Integration endpoints degrade gracefully — a failed call never blocks or rolls back a core business operation.