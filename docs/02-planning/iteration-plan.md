# Iteration Plan — CircleFund

## Iteration cadence

Iterations are time-boxed planning cycles. Each iteration delivers a potentially releasable increment of the product.

## Iteration 1 — Core Circle

### Sprint 1: Identity & Circle Foundation

**Goal:** Users can register, log in, and create savings circles.

**Stories:**

- US-I1-001: Register account
- US-I1-002: Verify account
- US-I1-003: Login
- US-I1-004: Recover account
- US-I1-005: Manage profile
- US-I1-006: Create dây hụi
- US-I1-007: Configure hụi type/rules

**Engineering focus:** Authentication, authorization foundation, user profile, circle aggregate, circle type, lifecycle.

### Sprint 2: Members, Shares & Periods

**Goal:** Circles can have members with shares, and periods can be generated.

**Stories:**

- US-I1-008: View dây
- US-I1-009: Close dây
- US-I1-010: Add member
- US-I1-011: Assign phần
- US-I1-012: View membership
- US-I1-013: Suspend/remove member
- US-I1-014: Generate kỳ
- US-I1-015: View kỳ schedule
- US-I1-016: Adjust permitted kỳ date

**Engineering focus:** Period generation, member membership, share assignment, membership invariants.

### Sprint 3: Contributions, Balance & Dashboard

**Goal:** Core financial workflow is functional.

**Stories:**

- US-I1-017: Record contribution
- US-I1-018: View payment status
- US-I1-019: View member balance
- US-I1-020: View kỳ balance
- US-I1-021: View dashboard
- US-I1-022: Receive reminder

**Engineering focus:** Contribution recording with validation, balance calculation, duplicate prevention, dashboard aggregation.

**Release outcome:** A chủ hụi can create a dây, add members, generate kỳ, record payments, and see balances.

## Iteration 2 — Financial Operations

### Sprint 4: Payouts & Bidding

**Stories:**

- US-I2-001: Record Hốt
- US-I2-002: Calculate payout
- US-I2-003: Submit Bid
- US-I2-004: Determine winning bid

**Testing priority:** Calculation, concurrency, duplicate operations, winner determination, payout correctness.

### Sprint 5: Interest, Rotation & Reconciliation

**Stories:**

- US-I2-005: Manage rotation
- US-I2-006: Record lottery result
- US-I2-007: Configure interest
- US-I2-008: Calculate interest
- US-I2-009: View interest history
- US-I2-010: Start reconciliation
- US-I2-011: Compare expected/actual
- US-I2-012: Resolve difference

**Focus:** Financial rules, rounding, state transitions, reconciliation.

### Sprint 6: Debt, Ledger & Reports

**Stories:**

- US-I2-013: View debt
- US-I2-014: View debt aging
- US-I2-015: Record debt settlement
- US-I2-016: View ledger
- US-I2-017: Reverse transaction
- US-I2-018: Generate dây report
- US-I2-019: Generate member statement
- US-I2-020: Export data

**Release gate:** All financial operations traceable, all calculations tested, audit history available, reports reconcile with ledger.

## Iteration 3 — Group Collaboration

### Sprint 7: Groups & Roles

**Stories:**

- US-I3-001: Create group
- US-I3-002: Invite members
- US-I3-003: Assign roles
- US-I3-004: View permissions

### Sprint 8: Communication & Governance

**Stories:**

- US-I3-005: Create announcement
- US-I3-006: Create vote
- US-I3-007: Create rules
- US-I3-008: Manage fines
- US-I3-009: Chat
- US-I3-010: Meetings
- US-I3-011: Tasks

## Iteration 4 — Platform Features

Covers accounts, budgets, invoices, documents, calendar, offline/sync, analytics, subscription, and community features.

## Iteration Planning Notes

Each iteration planning session produces:

- Sprint goal
- Prioritized user stories with acceptance criteria
- Technical tasks (migrations, API endpoints, UI components)
- Dependencies identified
- Risk assessment
- Testing strategy per story
