# Architecture Description — CircleFund

## 1. System Overview

CircleFund is an **offline-first** web/PWA application with a REST API backend and relational database. The client captures operations locally and synchronizes with the server when connectivity returns (see `ADR-001` and `ADR-002`). The server is the authoritative source for all financial records.

```text
┌─────────────────────────────────┐
│          CircleFund Web (PWA)    │
│        Vue 3 + TypeScript        │
│   Local Store + Operation Queue  │
└────────────────┬────────────────┘
                 │ REST API (HTTPS) + Sync
                 ▼
┌─────────────────────────────────┐
│        CircleFund API            │
│        ASP.NET Core              │
│  Application · Domain · Auth     │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│            EF Core               │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│           PostgreSQL             │
└─────────────────────────────────┘
```

## 2. Architecture Style

Domain-oriented, vertical-slice architecture with CQRS-inspired patterns. Features are organized as vertical slices (`Features/Hoi/CreateHoi/…`, `Features/Contributions/RecordContribution/…`), each containing endpoint, request, validator, handler, response, mapping, and tests.

## 3. Offline-First Foundation

The client maintains a **local store** (IndexedDB/SQLite) and an **operation queue**. Every writing slice in Iterations 1–2 follows this flow:

```text
Local action → Local write + local ID → Queue (IndexedDB/SQLite)
   → Connectivity → Sync to server → Server conflict check
   → Commit & mark synced | Flag for user resolution
```

- Local operations carry a unique **local ID** (`FR-I1-041`) and an idempotency key.
- Sync is FIFO and replays operations exactly once.
- Conflicts are surfaced for resolution, never silently discarded (`FR-I1-044`).
- Pending-sync financial records are never treated as authoritative (`FR-I2-049`).

## 4. Layers

- **Presentation (Frontend):** UI, client validation, Pinia state, local queue, offline cache, sync client.
- **Application (Backend):** API endpoints, command/query dispatch, validation, authorization, idempotency, transactions, outbox.
- **Domain:** entities, value objects, aggregate boundaries, invariants, financial calculations.
- **Infrastructure:** EF Core, external services (notification, storage, IdP, AI, analytics, subscription, backup), caching, background jobs.

## 5. Cross-Cutting Concerns

Every request passes through: Authentication → Authorization → Validation → Idempotency (mutations) → Logging → Error handling → Audit (where required). Financial mutations additionally wrap persistence, ledger entry, audit record, and outbox event in a single transaction.

## 6. Iteration-Architecture Mapping

| Iteration | Architectural additions |
| --- | --- |
| I1 | Identity (offline credential cache), local store + operation queue, sync engine + conflict detection, ROSCA aggregate (Circle/Round/Member/Share/Contribution/Balance) |
| I2 | Payout Draw, Bidding, Rotation/Lottery, Interest, Reconciliation, Debt, Ledger, P&L, Audit, Reports/Export, offline-aware financial handling |
| I3 | Integration adapters (notification, file storage, external IdP, AI, analytics, subscription, backup) with degradation policies |
| I4 | Group, membership, roles/permissions, voting, rules, fines, communication, meetings, tasks |
| I5 | Accounts, transfers, budgets, invoices, documents, calendar, import/export, sharing, community |

## 7. Key Decisions

| Decision | Status | Reference |
| --- | --- | --- |
| Offline-first | Accepted | ADR-001 |
| Sync strategy (queue-and-replay, exactly-once) | Accepted | ADR-002 |
| Append-only financial ledger | Accepted | ADR-003 |
| Idempotency keys | Accepted | ADR-004 |
| Money as fixed-precision decimal | Accepted | Business rules BR-FIN-001 |
| PostgreSQL | Accepted | — |

## 8. Technology Stack

Backend: C# / ASP.NET Core / EF Core / PostgreSQL / ASP.NET Core Identity. Frontend: Vue 3 / TypeScript / Vue Router / Pinia / PWA. Testing: xUnit, WebApplicationFactory, Playwright. Infra: Docker, GitHub Actions, Redis (progressive), object storage (progressive).