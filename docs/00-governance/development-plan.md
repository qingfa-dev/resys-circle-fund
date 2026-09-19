# Development Plan — CircleFund

## Development Method

CircleFund uses an incremental, Scrum-style development approach with four planned iterations, each delivering a working increment of functionality.

## Development Lifecycle

```text
Backlog
  ↓
Refinement
  ↓
Ready (Definition of Ready satisfied)
  ↓
In Progress
  ↓
Code Review
  ↓
CI / Automated Tests
  ↓
QA
  ↓
UAT
  ↓
Done
```

## Iteration Strategy

Each iteration delivers a potentially releasable increment. Iterations are time-boxed and follow a consistent rhythm of planning, development, review, and retrospective.

### Iteration 1 — Core Circle

**Goal:** Replace paper-based hụi ledger with a usable digital system.

**Focus areas:**

- Identity and authentication
- Savings circle management (CRUD, lifecycle)
- Members and shares
- Period generation and tracking
- Contribution recording
- Balance calculation
- Dashboard
- Notifications

**Sprints:** 3 sprints

### Iteration 2 — Financial Lifecycle

**Goal:** Complete the financial operations of the system.

**Focus areas:**

- Hốt (payouts)
- Bidding (đấu thầu)
- Rotation and lottery
- Interest calculations
- Balance reconciliation
- Debt management
- Financial ledger
- Audit trail
- Reports and export

**Sprints:** 4 sprints

### Iteration 3 — Group Collaboration

**Goal:** Evolve from personal manager to collaborative platform.

**Focus areas:**

- Groups and invitations
- Roles and permissions
- Announcements and voting
- Group rules
- Fines and appeals
- Chat and messaging
- Meetings and tasks

### Iteration 4 — Platform & Advanced Features

**Goal:** Extend into a broader financial/group platform.

**Focus areas:**

- Financial accounts and transfers
- Budgets and invoices
- Documents and calendar
- Import/export
- Offline mode and synchronization
- Backup and restore
- Analytics
- Subscription and community features

## Definition of Ready

A story should not enter development until:

- [ ] Business objective is clear
- [ ] Acceptance criteria are testable
- [ ] Dependencies identified
- [ ] UX requirements defined
- [ ] Domain rules identified
- [ ] Permission requirements known
- [ ] Data requirements understood
- [ ] Technical uncertainty acceptable
- [ ] Story is estimable

## Definition of Done

A user story becomes **Done** only when:

- [ ] Acceptance criteria satisfied
- [ ] Backend implemented
- [ ] Frontend implemented when applicable
- [ ] Database migration complete
- [ ] Validation implemented
- [ ] Authorization implemented
- [ ] Error handling implemented
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] API tests passing
- [ ] Relevant E2E tests passing
- [ ] Code reviewed
- [ ] CI passing
- [ ] Documentation updated
- [ ] Audit implemented where required
- [ ] Observability implemented where required
- [ ] No known critical defects
- [ ] Deployable

## Technical Practices

- Domain-first development: business rules in domain/application layer
- Financial consistency: atomic transactions for multi-record operations
- Auditability: all financial operations traceable
- No silent history changes: corrections via compensating transactions
- Security by design: authorization considered at design time
- Test-driven development where practical
- Small increments: working increments over big-bang delivery
