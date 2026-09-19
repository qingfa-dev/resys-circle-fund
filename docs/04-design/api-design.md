# API Design — Index

REST API for the Vue 3 frontend. Decomposed under `api-design/`:

| File | Content |
| --- | --- |
| `01-conventions.md` | Base URL, versioning, response/error conventions, endpoint patterns, validation/rate limits |
| `02-auth-identity.md` | Auth & identity endpoints |
| `03-circles-rounds-members.md` | Circle, round, member, share endpoints |
| `04-contributions-balance.md` | Contribution & balance endpoints + example |
| `05-payout-bidding.md` | Payout Draw, bidding, rotation endpoints |
| `06-ledger-audit-reports.md` | Ledger, audit, reports, export endpoints |
| `07-offline-sync.md` | Offline/sync endpoints |
| `08-integrations.md` | I3 integration endpoints |
| `09-collaboration-platform.md` | I4/I5 endpoints |

Conventions: Bearer token auth; `Idempotency-Key` on financial mutations; OpenAPI contract (NFR-024/025).