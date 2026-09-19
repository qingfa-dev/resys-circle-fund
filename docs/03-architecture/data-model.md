# Data Model — CircleFund

## Overview

The data model defines the database schema for CircleFund using Entity Framework Core with PostgreSQL. Financial data uses `numeric(18,2)` or `decimal(18,2)` precision. All financial tables include created_at, created_by, and correlation_id columns for auditability.

## Entity-Relationship Diagram (Summary)

```text
Users (ASP.NET Core Identity)
│
├── Circles
│   │
│   ├── CircleConfigurations
│   │
│   ├── CircleMembers
│   │   └── CircleShares (one-to-many)
│   │
│   ├── Periods
│   │   ├── Contributions (one per member per period)
│   │   │
│   │   ├── Bids
│   │   │
│   │   └── Payouts
│   │
│   └── LedgerEntries (all financial events)
│
├── AuditRecords (all auditable actions)
│
└── Notifications
```

## Tables

### AspNetUsers (from ASP.NET Core Identity)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | User identifier |
| UserName | text | Unique | Login name |
| Email | text | Unique | Email address |
| EmailConfirmed | bool | | Email verification status |
| PasswordHash | text | | Hashed password |
| FullName | text | | Display name |
| PhoneNumber | text | | Phone number |
| PhoneNumberConfirmed | bool | | Phone verification |
| IsActive | bool | | Account active status |
| CreatedAt | timestamptz | | Account creation timestamp |
| UpdatedAt | timestamptz | | Last update timestamp |

### Circles

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Circle identifier |
| Name | text | NOT NULL, unique | Circle name |
| Type | integer | NOT NULL | Hụi type (enum) |
| Status | integer | NOT NULL, default 0 | Circle status (enum) |
| Configuration | jsonb | NOT NULL | Circle configuration |
| StartDate | date | NOT NULL | Circle start date |
| CreatedBy | uuid | FK → AspNetUsers | Creator |
| CreatedAt | timestamptz | NOT NULL, default now() | Creation timestamp |
| UpdatedAt | timestamptz | | Last update timestamp |
| CorrelationId | uuid | | Correlation ID for operations |
| DeletedAt | timestamptz | | Soft delete timestamp |

### CircleConfigurations (embedded in Circles as jsonb for flexibility)

| Field | Type | Description |
|-------|------|-------------|
| ContributionAmount | numeric(18,2) | Per-period contribution amount |
| ScheduleFrequency | text | Weekly, biweekly, monthly |
| DueDay | integer | Day of month for contributions |
| NumberOfRounds | integer \| null | Total rounds (null = indefinite) |
| InterestRate | numeric(18,4) \| null | Interest rate for FixedInterest type |
| BiddingRules | jsonb \| null | Bidding configuration |
| RoundingStrategy | text | Rounding policy |
| AllowPartialPayment | boolean | Whether partial payments allowed |
| MinMembers | integer | Minimum members required |

### CircleMembers

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Membership record ID |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| UserId | uuid | FK → AspNetUsers, NOT NULL | Member user ID |
| Status | integer | NOT NULL, default 0 | Member status (Active, Suspended, Removed) |
| JoinedAt | timestamptz | NOT NULL, default now() | Join timestamp |
| RemovedAt | timestamptz | | Removal timestamp |
| CreatedAt | timestamptz | NOT NULL | Record creation timestamp |
| UpdatedAt | timestamptz | | Record update timestamp |
| CorrelationId | uuid | | Correlation ID |

**Constraints:**
- UNIQUE (CircleId, UserId) — one membership per user per circle

### CircleShares

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Share identifier |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| MemberId | uuid | FK → CircleMembers, NOT NULL | Member identifier |
| ShareNumber | integer | NOT NULL | Share number within circle |
| Status | integer | NOT NULL, default 0 | Share status |
| AssignedAt | timestamptz | NOT NULL | Assignment timestamp |
| CreatedAt | timestamptz | NOT NULL | Record creation timestamp |
| UpdatedAt | timestamptz | | Record update timestamp |
| CorrelationId | uuid | | Correlation ID |

**Constraints:**
- UNIQUE (CircleId, ShareNumber) — share numbers unique per circle
- UNIQUE (CircleId, MemberId, ShareNumber) — prevent duplicate assignment (if single share per member)
- Index on (CircleId, MemberId) for member share queries

### Periods

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Period identifier |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| PeriodNumber | integer | NOT NULL | Sequential period number |
| ScheduledDate | date | NOT NULL | Scheduled date |
| Status | integer | NOT NULL, default 0 | Period status |
| OpenedAt | timestamptz | | When period was opened |
| CompletedAt | timestamptz | | When period was completed |
| ClosedAt | timestamptz | | When period was closed |
| CreatedAt | timestamptz | NOT NULL | Record creation timestamp |
| CorrelationId | uuid | | Correlation ID |

**Constraints:**
- UNIQUE (CircleId, PeriodNumber) — period numbers unique per circle
- CHECK (PeriodNumber > 0)

**Index:** UNIQUE (CircleId, ScheduledDate)

### Contributions

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Contribution identifier |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| PeriodId | uuid | FK → Periods, NOT NULL | Period identifier |
| MemberId | uuid | FK → CircleMembers, NOT NULL | Member identifier |
| ShareId | uuid | FK → CircleShares, NOT NULL | Share identifier |
| Amount | numeric(18,2) | NOT NULL | Contribution amount |
| DueDate | date | NOT NULL | Payment due date |
| PaymentDate | timestamptz | | Actual payment date |
| PaymentMethod | text | | Payment method description |
| Reference | text | | External reference |
| Status | integer | NOT NULL, default 0 | Payment status |
| IdempotencyKey | uuid | UNIQUE, nullable | Idempotency key |
| RecordedBy | uuid | FK → AspNetUsers | Recording user |
| RecordedAt | timestamptz | NOT NULL, default now() | Recording timestamp |
| CreatedAt | timestamptz | NOT NULL | Record creation timestamp |
| CorrelationId | uuid | | Correlation ID |
| DeletedAt | timestamptz | | Soft delete timestamp |

**Constraints:**
- UNIQUE (CircleId, PeriodId, MemberId, ShareId) — one contribution per member per share per period
- CHECK (Amount > 0)
- FK (PeriodId) → Periods must exist

**Index:** (CircleId, MemberId, PeriodId, Status) for member queries
**Index:** (IdempotencyKey) for deduplication

### Bids

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Bid identifier |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| PeriodId | uuid | FK → Periods, NOT NULL | Period identifier |
| MemberId | uuid | FK → CircleMembers, NOT NULL | Member identifier |
| Amount | numeric(18,2) | NOT NULL | Bid amount |
| SubmittedAt | timestamptz | NOT NULL, default now() | Submission timestamp |
| Status | integer | NOT NULL, default 0 | Bid status |
| ReplacedById | uuid | FK → Bids (self-reference) | Replacing bid ID |
| CreatedAt | timestamptz | NOT NULL | Record creation timestamp |
| CorrelationId | uuid | | Correlation ID |

**Constraints:**
- CHECK (Amount > 0)
- FK (ReplacedById) → Bids

**Index:** (CircleId, PeriodId, MemberId) for member bid queries

### Payouts

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Payout identifier |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| PeriodId | uuid | FK → Periods, NOT NULL | Period identifier |
| RecipientId | uuid | FK → CircleMembers, NOT NULL | Recipient member |
| GrossAmount | numeric(18,2) | NOT NULL | Total pool amount |
| InterestAmount | numeric(18,2) | | Interest amount (if applicable) |
| DiscountAmount | numeric(18,2) | | Discount/fee amount |
| NetAmount | numeric(18,2) | NOT NULL | Net payout amount |
| PayoutDate | timestamptz | | Date of payout |
| PayoutMethod | text | | Payout method |
| Status | integer | NOT NULL, default 0 | Payout status |
| RecordedBy | uuid | FK → AspNetUsers | Recording user |
| RecordedAt | timestamptz | NOT NULL | Recording timestamp |
| CreatedAt | timestamptz | NOT NULL | Record creation timestamp |
| CorrelationId | uuid | | Correlation ID |
| ReversedById | uuid | FK → Payouts (self-reference) | Reversing payout ID |
| DeletedAt | timestamptz | | Soft delete timestamp |

**Constraints:**
- CHECK (GrossAmount > 0)
- CHECK (NetAmount <= GrossAmount)
- UNIQUE (CircleId, PeriodId, RecipientId) — one payout per recipient per period

### LedgerEntries

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Ledger entry identifier |
| CircleId | uuid | FK → Circles, NOT NULL | Circle identifier |
| PeriodId | uuid | FK → Periods | Period identifier (nullable) |
| MemberId | uuid | FK → CircleMembers | Member identifier (nullable) |
| TransactionType | integer | NOT NULL | Transaction type enum |
| Amount | numeric(18,2) | NOT NULL | Transaction amount |
| BalanceAfter | numeric(18,2) | NOT NULL | Running balance after entry |
| Description | text | | Entry description |
| ReferenceId | uuid | | ID of originating entity |
| ReferenceType | text | NOT NULL | Type of originating entity |
| CorrelationId | uuid | | Correlation ID |
| CreatedAt | timestamptz | NOT NULL, default now() | Creation timestamp |
| CreatedBy | uuid | FK → AspNetUsers | Creating user |

**Constraints:**
- CHECK (Amount != 0)
- NOT VALID constraint on BalanceAfter (calculated, not enforced)

**Index:** (CircleId, CreatedAt) for chronological queries
**Index:** (CircleId, MemberId, CreatedAt) for member statements
**Index:** (ReferenceType, ReferenceId) for traceability

### AuditRecords

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Audit record identifier |
| ActorId | uuid | FK → AspNetUsers | Who performed the action |
| Action | text | NOT NULL | Action performed |
| ResourceType | text | NOT NULL | Type of resource affected |
| ResourceId | uuid | | ID of specific resource |
| Timestamp | timestamptz | NOT NULL, default now() | When the action occurred |
| BeforeState | jsonb | | State before change |
| AfterState | jsonb | | State after change |
| CorrelationId | uuid | | Correlation ID |
| Reason | text | | Reason for the action |

**Index:** (ResourceType, ResourceId) for entity history
**Index:** (ActorId, Timestamp) for user activity
**Index:** (CorrelationId) for operation tracing

### Notifications

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| Id | uuid | PK | Notification identifier |
| UserId | uuid | FK → AspNetUsers, NOT NULL | Recipient user |
| Type | text | NOT NULL | Notification type |
| Title | text | | Notification title |
| Message | text | | Notification message |
| ReferenceType | text | | Related entity type |
| ReferenceId | uuid | | Related entity ID |
| Status | integer | NOT NULL, default 0 | Delivery status |
| SentAt | timestamptz | | When sent |
| DeliveredAt | timestamptz | | When delivered |
| CreatedAt | timestamptz | NOT NULL | Creation timestamp |
| ReadAt | timestamptz | | When read by user |

### Database Indexes Summary

| Table | Columns | Type | Purpose |
|-------|---------|------|---------|
| Circles | Name | Unique | Circle name lookup |
| Periods | (CircleId, PeriodNumber) | Unique | Period number per circle |
| Periods | (CircleId, ScheduledDate) | Unique | Date uniqueness per circle |
| Contributions | (CircleId, PeriodId, MemberId, ShareId) | Unique | Prevent duplicate contributions |
| Contributions | IdempotencyKey | Unique | Request deduplication |
| Contributions | (CircleId, MemberId, PeriodId, Status) | Index | Member contribution queries |
| CircleShares | (CircleId, MemberId) | Index | Member shares query |
| LedgerEntries | (CircleId, MemberId, CreatedAt) | Index | Member statement generation |
| LedgerEntries | (ReferenceType, ReferenceId) | Index | Transaction traceability |
| AuditRecords | (ResourceType, ResourceId) | Index | Entity audit history |
| AuditRecords | CorrelationId | Index | Operation tracing |

## Migration Strategy

- EF Core migrations for schema changes
- Each migration includes both Up and Down (rollback) methods
- Migrations are reviewed before applying to production
- Database constraints (CHECK, UNIQUE, FK) enforced where practical
- Seed/reference data applied via migrations
