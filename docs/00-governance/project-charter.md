# Project Charter — CircleFund

## Overview

**CircleFund** is an open-source application for managing rotating savings and credit associations (ROSCAs) — known in Vietnamese as **Hụi / Họ**. It manages contributions, payouts, members, rounds, and financial records.

The product is designed **offline-first**: core operations work without connectivity and synchronize once a connection returns. See `docs/03-architecture/adr/ADR-001-offline-first.md`.

## Vision

Provide a modern digital system for managing rotating savings groups that preserves the community-based nature of Hụi while replacing paper-based, error-prone record keeping — usable with or without connectivity from the first release.

## Objectives

1. Digitize Savings Circle management (create, configure, track circles, members, rounds) — **offline-capable from day one**
2. Automate contribution recording, balance calculation, and payout workflows
3. Support the three common ROSCA variants (No-Interest Rotation, Fixed Interest, Bidding)
4. Maintain an append-only, auditable financial ledger
5. Provide role- and resource-based access control across diverse participant types
6. Integrate with external services (notifications, storage, auth, AI, analytics, backup, subscription) with graceful degradation

## Success Criteria

- A Circle Organizer can create a circle, add members, generate rounds, record contributions, and see balances — fully offline, syncing automatically once back online
- Financial calculations are correct and auditable
- Duplicate and conflicting financial operations are prevented, never silently overwritten
- Core workflows are verified at multiple test levels (unit → integration → API → concurrency → offline/sync → E2E)

## Scope

CircleFund is delivered incrementally across five independently releasable iterations (full detail in `docs/01-requirements/srs.md`):

```text
Iteration 1  Offline-First Core ROSCA Management
Iteration 2  Financial Operations (Offline-Capable)
Iteration 3  Integrations (External Services)
Iteration 4  Group Collaboration & Governance
Iteration 5  Advanced Platform
```

### In Scope — Iteration 1 (Core)

Identity (with offline login), local storage/operation queue, Savings Circle lifecycle, Round scheduling, Member & Share management, Contribution recording, Balance calculation, Dashboard, Notifications, and Synchronization with conflict detection.

### In Scope — Later Iterations

Iteration 2 completes financial operations (Payout Draw, Bidding, rotation, interest, reconciliation, debt, ledger, P&L, audit, reports, export) with offline-aware handling. Iteration 3 adds integrations. Iteration 4 adds collaboration. Iteration 5 adds back-office/platform features.

### Out of Scope

- Anything not enumerated in the SRS iteration scope
- Native mobile applications (the product is a web/PWA app)

## Stakeholders

| Role | Description |
| --- | --- |
| Project Owner | Defines vision, priorities, acceptance criteria |
| Development Team | Designs, builds, tests, deploys |
| Circle Organizers | Primary users who manage circles |
| Circle Members | Participants who contribute and receive payouts |
| System Administrator | Operates and integrates the platform |
| Contributors | Open-source developers and reviewers |

## Constraints

- Open-source under MIT License
- Technology stack: Vue 3 + TypeScript (frontend), ASP.NET Core (backend), PostgreSQL (database)
- Financial calculations use fixed-precision decimal arithmetic only
- Server is the authoritative source for financial records; the client is a synchronization client
- External integrations must degrade gracefully

## Governance

- Requirements follow IEEE 29148-2018 (`docs/01-requirements/srs.md`)
- Architectural decisions are recorded as ADRs (`docs/03-architecture/adr/`)
- Scope, architecture, and financial-rule changes follow `docs/10-maintenance/change-management.md`