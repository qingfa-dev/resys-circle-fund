# Coding Standards — Structure & Offline Conventions

**Index:** `docs/05-development/coding-standards.md`

## Project Structure (Backend)

```text
src/
├── CircleFund.Api/            Controllers, Middleware, Extensions
├── CircleFund.Application/    Features/<Feature>/<Action>/
│   └── Common/                Interfaces, Models, Validators, Behaviors
├── CircleFund.Domain/         Entities, ValueObjects, Enums, Events, Exceptions, Rules
├── CircleFund.Infrastructure/ Persistence, Auth, ExternalServices
└── CircleFund.Tests/          UnitTests, IntegrationTests, ApiTests
```

Frontend: `components/`, `composables/`, `pages/`, `stores/`, `services/`, `types/`, `utils/`.

## Offline-First Conventions

1. Writing slices (I1–I2) go through the local operation queue, not straight to the server.
2. Local operations carry `localId` (UUID) + `idempotencyKey`.
3. Sync status is a first-class field on every financial record.
4. Never treat a pending-sync record as authoritative in balance/ledger/report.
5. Financial mutations are idempotent; replay is exactly-once.

## Dependency Rule

```text
Presentation → Application → Domain
                        → Infrastructure → Persistence
Tests → all layers
```

Domain has no project dependencies; no circular references.