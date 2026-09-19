# Business Rules — CircleFund

## Purpose

This document defines the business rules that govern CircleFund's domain operations. These rules are authoritative and must be enforced by the application regardless of UI or implementation changes.

## Category: Circle Rules

### BR-CIR-001: Circle Ownership

A circle must have exactly one organizer (Chủ Hụi) at all times. If the organizer is removed, ownership must be transferred to another authorized member.

### BR-CIR-002: Circle Status Lifecycle

A circle transitions through states:

```text
Active → Paused → Active
Active → Closed → Archived
```

Contributions cannot be recorded for a circle in Closed state.

### BR-CIR-003: Circle Configuration

A circle is configured with:

- Name (required, unique within organization)
- Type: Non-interest, Fixed Interest, or Bidding
- Start date
- Contribution schedule (frequency, due date)
- Number of rounds (or indefinite)
- Number of shares per member
- Contribution amount

### BR-CIR-004: Circle Types

Supported circle types:

| Type | Description |
|------|-------------|
| Non-interest (Không lãi) | Fixed rotation or lottery for payout recipient |
| Fixed Interest (Lãi cố định) | Interest calculated on contributions |
| Bidding (Đấu thầu) | Members bid for the right to receive funds |

### BR-CIR-005: Unique Circle Name

Circle names must be unique within the scope of the organizer's circles.

## Category: Member Rules

### BR-MEM-001: Membership

A member can belong to multiple circles but can only hold one share (or configured multiple shares) per circle per period.

### BR-MEM-002: Member Status Lifecycle

```text
Active → Suspended → Active
Active → Removed
```

Suspended members cannot make contributions but retain their share assignments.

### BR-MEM-003: Share Assignment

Shares must be assigned before the first period opens. Share changes after periods have opened require authorization and audit recording.

### BR-MEM-004: Minimum Members

A circle must have at least 2 members (organizer + 1 participant) before the first period opens.

## Category: Contribution Rules

### BR-CON-001: Contribution Amount

Contribution amount must match the configured amount for the circle and period, or be a valid partial payment (if partial payments are allowed).

### BR-CON-002: Payment Deadline

Contributions are due by the configured deadline for each period. Overdue contributions are tracked separately.

### BR-CON-003: Duplicate Prevention

A member can only have one recorded contribution per share per period. Duplicate submissions are rejected with an appropriate error.

### BR-CON-004: Contribution State

Contribution states: `Unpaid`, `Partial`, `Paid`, `Overdue`, `Waived`, `Cancelled`.

### BR-CON-005: Correction via Compensation

Financial corrections must not overwrite history. Instead, a compensating transaction (reversal + correction) is created preserving the original record.

## Category: Payout Rules

### BR-PAY-001: Payout Eligibility

A member is eligible for payout when:

- They have an active share in the circle
- The period is open and designated for payout
- They have met the contribution requirements (or the circle rules allow otherwise)

### BR-PAY-002: Single Recipient Per Period

In non-bidding circles, only one member receives the payout per period. In bidding circles, the highest bidder receives the payout.

### BR-PAY-003: Rotation Order

For non-interest circles using rotation, the payout rotates among eligible members according to the configured order. A member cannot receive payout twice until all eligible members have received it (unless configured otherwise).

## Category: Bidding Rules

### BR-BID-001: Bid Validity

Bids are only accepted when the bidding period is open for the circle.

### BR-BID-002: Bid Amount

The bid amount must meet or exceed the configured minimum bid amount.

### BR-BID-003: Winner Determination

The winning bid is determined according to the configured rule (highest amount, lowest amount, or custom rule).

### BR-BID-004: Bid Uniqueness

A member can only place one active bid per period. A new bid replaces the previous bid (recorded as a new entry with timestamps).

## Category: Financial Rules

### BR-FIN-001: Fixed Precision Arithmetic

All monetary calculations use fixed-precision decimal arithmetic. Floating-point types are never used for financial calculations.

### BR-FIN-002: Ledger is Append-Only

Financial ledger entries are never deleted or modified. Corrections are made by creating compensating entries.

### BR-FIN-003: Balance Calculation

Member balances are derived from authoritative ledger entries, not stored as mutable values.

### BR-FIN-004: Transaction Atomicity

A financial operation affecting multiple records (contribution + balance update + ledger entry + audit) must succeed or fail as a single transaction.

### BR-FIN-005: Idempotency

All financial mutation endpoints require idempotency keys to prevent duplicate processing.

### BR-FIN-006: Interest Calculation

Interest is calculated based on the configured rate, the contribution amount, and the time period. Historical calculations are not affected by later rate changes.

### BR-FIN-007: Rounding

Rounding follows the configured rounding strategy (typically half-up) at the final step of calculation, not at intermediate steps.

## Category: Reconciliation Rules

### BR-REC-001: Reconciliation Scope

Reconciliation compares expected amounts (based on contributions and configured rules) against actual ledger entries for a period.

### BR-REC-002: Discrepancy Handling

Any discrepancy found during reconciliation must be authorized by an approved user and recorded as an adjustment entry in the ledger.

## Category: Audit Rules

### BR-AUD-001: Audit Capture

The following operations must be audited:

- All financial mutations (contributions, payouts, adjustments, reversals)
- Circle lifecycle changes (create, update, close, archive)
- Member changes (add, remove, suspend, share assignment)
- Permission changes
- Configuration changes

### BR-AUD-002: Audit Content

Each audit record captures: actor, action, timestamp, resource, before state, after state, correlation ID, reason (if applicable).
