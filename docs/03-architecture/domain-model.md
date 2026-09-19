# Domain Model — CircleFund

## Overview

The domain model represents the core business concepts of CircleFund, organized by bounded context.

## Core Domain: Savings Circle

```text
Savings Circle (Dây Hụi)
│
├── Identity
│   ├── Id (GUID)
│   ├── Name
│   ├── Type (NonInterest, FixedInterest, Bidding)
│   ├── Status (Active, Paused, Closed, Archived)
│   ├── CreatedAt
│   ├── CreatedBy
│   └── Configuration (JSON/structured)
│
├── Circle Configuration
│   ├── ContributionAmount (decimal)
│   ├── Schedule (frequency, due day)
│   ├── StartDate
│   ├── NumberOfRounds (or indefinite)
│   ├── InterestRate (nullable, for FixedInterest)
│   ├── BiddingRules (nullable, for Bidding)
│   └── RoundingRule
│
├── Members (Hụi Viên)
│   │
│   ├── Member
│   │   ├── Id (GUID)
│   │   ├── UserId (GUID)
│   │   ├── CircleId (GUID)
│   │   ├── Status (Active, Suspended, Removed)
│   │   ├── JoinedAt
│   │   └── RemovedAt (nullable)
│   │
│   └── Membership History
│       ├── Log entries (join, suspend, remove)
│       └── Timestamps
│
├── Shares (Phần Hụi)
│   │
│   ├── Share
│   │   ├── Id (GUID)
│   │   ├── MemberId (GUID)
│   │   ├── CircleId (GUID)
│   │   ├── ShareNumber
│   │   ├── AssignedAt
│   │   └── Status (Active, Transferred)
│   │
│   └── Share History
│       ├── Assignment records
│       └── Transfer records
│
├── Periods (Kỳ Hụi)
│   │
│   ├── Period
│   │   ├── Id (GUID)
│   │   ├── CircleId (GUID)
│   │   ├── PeriodNumber (sequential)
│   │   ├── ScheduledDate
│   │   ├── Status (Scheduled, Open, Completed, Closed, Cancelled)
│   │   ├── CreatedAt
│   │   └── CompletedAt (nullable)
│   │
│   └── Period Lifecycle
│       Scheduled → Open → Completed → Closed
│
├── Contributions (Đóng Hụi)
│   │
│   ├── Contribution
│   │   ├── Id (GUID)
│   │   ├── MemberId (GUID)
│   │   ├── CircleId (GUID)
│   │   ├── PeriodId (GUID)
│   │   ├── ShareId (GUID)
│   │   ├── Amount (decimal)
│   │   ├── DueDate
│   │   ├── PaymentDate (nullable)
│   │   ├── PaymentMethod
│   │   ├── Reference
│   │   ├── Status (Unpaid, Partial, Paid, Overdue, Waived, Cancelled)
│   │   ├── RecordedBy (UserId)
│   │   └── RecordedAt
│   │
│   └── Contribution Idempotency
│       └── IdempotencyKey (unique per operation)
│
├── Bids (Đấu Thầu)
│   │
│   ├── Bid
│   │   ├── Id (GUID)
│   │   ├── MemberId (GUID)
│   │   ├── CircleId (GUID)
│   │   ├── PeriodId (GUID)
│   │   ├── Amount (decimal)
│   │   ├── SubmittedAt
│   │   └── Status (Active, Replaced, Cancelled)
│   │
│   └── Winner
│       ├── PeriodId
│       ├── MemberId
│       ├── BidId
│       └── DeterminedAt
│
├── Payouts (Hốt Hụi)
│   │
│   ├── Payout
│   │   ├── Id (GUID)
│   │   ├── CircleId (GUID)
│   │   ├── PeriodId (GUID)
│   │   ├── RecipientId (MemberId)
│   │   ├── PayoutAmount (decimal)
│   │   ├── NetAmount (after discounts/interest)
│   │   ├── PayoutDate
│   │   ├── PayoutMethod
│   │   ├── Status (Pending, Completed, Reversed)
│   │   └── RecordedBy
│   │
│   └── Payout Calculation
│       ├── Total pool amount
│       ├── Interest/deduction calculation
│       └── Net payout amount
│
└── Financial Ledger (Sổ Hụi)
    │
    ├── Ledger Entry
    │   ├── Id (GUID)
    │   ├── CircleId (GUID)
    │   ├── PeriodId (GUID) (nullable)
    │   ├── MemberId (GUID) (nullable)
    │   ├── TransactionType (Contribution, Payout, Interest, Fee, Adjustment, Reversal, Other)
    │   ├── Amount (decimal)
    │   ├── BalanceAfter (decimal)
    │   ├── Description
    │   ├── ReferenceId (ID of originating entity)
    │   ├── ReferenceType (Contribution, Payout, Bid, etc.)
    │   ├── CorrelationId (GUID)
    │   ├── CreatedAt
    │   └── CreatedBy (UserId)
    │
    └── Ledger Rules
        ├── Append-only (no modification/deletion)
        ├── Corrections via compensating entries
        └── Each entry references originating operation

└── Audit Trail
    │
    ├── Audit Record
    │   ├── Id (GUID)
    │   ├── ActorId (UserId)
    │   ├── Action (string)
    │   ├── ResourceType
    │   ├── ResourceId
    │   ├── Timestamp
    │   ├── BeforeState (JSON)
    │   ├── AfterState (JSON)
    │   ├── CorrelationId (GUID)
    │   └── Reason (nullable)
    │
    └── Audit Rules
        ├── Records all financial mutations
        ├── Records circle lifecycle changes
        ├── Records member changes
        ├── Records permission changes
        └── Records configuration changes

## Cross-Cutting Domain Concepts

### Money

- All monetary values use `decimal` type (128-bit fixed precision)
- Currency: VND (Vietnamese Dong) as default, extensible to other currencies
- Rounding: Half-up, applied at final calculation step only
- No floating-point arithmetic anywhere

### Balance

- Member balance = sum of all ledger entries for that member
- Balance is a derived value, never manually edited
- Balance calculation is deterministic from ledger entries
- Balance read models are cached and refreshed on mutations

### Idempotency

- All financial mutation endpoints require an idempotency key
- Idempotency key: client-generated UUID per unique operation
- Server stores key + result for a configurable retention period
- Duplicate key returns stored result without re-processing

### Correlation

- All related operations share a CorrelationId
- CorrelationId traces a logical operation across entities, logs, and events
- Enables investigation of a complete business transaction across the system

## Domain Events

| Event | Trigger |
|-------|---------|
| CircleCreated | New circle created |
| CircleStatusChanged | Circle paused/closed/activated |
| MemberAdded | New member joined circle |
| MemberStatusChanged | Member suspended/removed |
| ShareAssigned | Share assigned to member |
| PeriodGenerated | New period created |
| PeriodStatusChanged | Period opened/completed/closed |
| ContributionRecorded | Payment recorded |
| ContributionReversed | Contribution correction |
| PayoutRecorded | Payout completed |
| PayoutReversed | Payout correction |
| BidRecorded | New bid placed |
| WinnerDetermined | Bid winner selected |
| LedgerEntryCreated | Financial entry recorded |
| AuditRecordCreated | Audit trail entry added |
| BalanceRecalculated | Balance recomputed |
