# Project Charter — CircleFund

## Overview

**CircleFund** is an open-source web application for managing community-based rotating savings groups (Hụi / Họ) and their financial activities.

## Vision

Provide a modern digital system for managing rotating savings circles, preserving the underlying concept of community-based rotating savings while replacing paper-based, error-prone management with reliable software.

## Objectives

1. Digitize savings circle management (create, configure, track circles, members, rounds)
2. Automate contribution tracking and balance calculations
3. Support multiple payout mechanisms (rotation, bidding, lottery)
4. Maintain an auditable financial ledger
5. Provide role-based access control for diverse participant types
6. Support PWA for cross-device access

## Scope

### In Scope (Phase 1 — Core Circle)

- User registration, authentication, and profile management
- Savings circle creation, configuration, and lifecycle management
- Member and share management
- Period/round generation and tracking
- Contribution recording and payment status tracking
- Balance calculation
- Dashboard and notifications

### In Scope (Phase 2 — Financial Lifecycle)

- Payouts and Hốt
- Bidding and lottery mechanisms
- Interest calculations
- Debt tracking
- Financial ledger with audit trail
- Reconciliation
- Reports and export

### Out of Scope (Initial)

- Full offline mode with synchronization
- Mobile native applications
- Third-party payment integration
- AI-assisted workflows
- Community platform features

## Stakeholders

| Role | Description |
|------|-------------|
| Project Owner | Defines vision, priorities, and acceptance criteria |
| Development Team | Designs, builds, tests, and deploys the application |
| Circle Organizers (Chủ Hụi) | Primary users who manage circles |
| Members (Hụi Viên) | Participants who contribute and receive payouts |
| Contributors | Open-source developers and reviewers |

## Success Criteria

- Circle organizers can replace paper ledgers with the application
- Financial calculations are correct and auditable
- System prevents duplicate financial operations
- Core workflows are testable and verified at multiple levels

## Constraints

- Open-source under MIT License
- Technology stack: Vue 3 + TypeScript (frontend), ASP.NET Core (backend), PostgreSQL (database)
- Financial calculations must use fixed-precision arithmetic (no floating-point)
- Server is the authoritative source for financial records

## Governance

- Decisions are made through transparent discussion and documented in this repository
- All architectural decisions are recorded as ADRs in `docs/03-architecture/adr/`
- Changes to scope, architecture, or financial rules follow the change management process (see `docs/10-maintenance/change-management.md`)
