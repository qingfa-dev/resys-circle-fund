# Data Model — Core Tables (column-level)

PostgreSQL via EF Core. Money: `numeric(18,2)`. Feature-prefixed tables are snake_case.

## AspNetUsers (Identity)

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| UserName | text | N | UNIQUE |
| Email | text | Y | UNIQUE |
| EmailConfirmed | bool | N | |
| PasswordHash | text | N | |
| FullName | text | Y | |
| PhoneNumber | text | Y | |
| PhoneNumberConfirmed | bool | N | |
| IsActive | bool | N | |
| CreatedAt | timestamptz | N | |
| UpdatedAt | timestamptz | Y | |

## Circles

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| Name | text | N | UNIQUE per organizer |
| Type | int | N | NoInterest=0, FixedInterest=1, Bidding=2 |
| Status | int | N | Active=0, Paused=1, Closed=2, Archived=3 |
| Configuration | jsonb | N | amount, frequency, dueDay, rounds, shares, interestRate, biddingRules, rounding, allowPartial |
| StartDate | date | N | |
| CreatedBy | uuid | N | FK→AspNetUsers |
| CreatedAt | timestamptz | N | default now() |
| UpdatedAt | timestamptz | Y | |
| CorrelationId | uuid | Y | |

## Rounds

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| CircleId | uuid | N | FK→Circles |
| RoundNumber | int | N | UNIQUE (CircleId, RoundNumber); >0 |
| ScheduledDate | date | N | UNIQUE (CircleId, ScheduledDate) |
| Status | int | N | Scheduled/Open/Completed/Closed/Cancelled |
| OpenedAt / CompletedAt / ClosedAt | timestamptz | Y | |
| CreatedAt | timestamptz | N | |
| CorrelationId | uuid | Y | |

## CircleMembers / CircleShares

**CircleMembers:** `Id` (PK), `CircleId` (FK), `UserId` (FK), `Status` (int), `JoinedAt`, `RemovedAt`, `CreatedAt`, `CorrelationId`. UNIQUE (CircleId, UserId).

**CircleShares:** `Id` (PK), `CircleId` (FK), `MemberId` (FK→CircleMembers), `ShareNumber` (int), `Status` (int), `AssignedAt`. UNIQUE (CircleId, ShareNumber); index (CircleId, MemberId).

## Contributions

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| CircleId / MemberId / ShareId | uuid | N | FKs |
| RoundId | uuid | N | FK→Rounds |
| Amount | numeric(18,2) | N | CHECK(Amount > 0) |
| DueDate | date | N | |
| PaymentDate | timestamptz | Y | |
| PaymentMethod / Reference | text | Y | |
| Status | int | N | Unpaid/Partial/Paid/Overdue/Waived/Cancelled |
| IdempotencyKey | uuid | Y | UNIQUE |
| RecordedBy | uuid | N | FK→AspNetUsers |
| RecordedAt | timestamptz | N | |
| CorrelationId / DeletedAt | uuid/timestamptz | Y | |

UNIQUE (CircleId, RoundId, MemberId, ShareId). Index (CircleId, MemberId, RoundId, Status); index (IdempotencyKey).

## Bids

`Id` (PK), `CircleId`, `RoundId`, `MemberId`, `Amount` numeric(18,2) CHECK(>0), `SubmittedAt`, `Status` (int), `ReplacedById` (FK→Bids, self). Index (CircleId, RoundId, MemberId).

## Payouts

`Id` (PK), `CircleId`, `RoundId`, `RecipientId`, `GrossAmount` CHECK(>0), `InterestAmount` (Y), `DiscountAmount` (Y), `NetAmount` CHECK(Net ≤ Gross), `PayoutDate`, `PayoutMethod`, `Status` (int), `RecordedBy`, `RecordedAt`, `CorrelationId`, `ReversedById` (self-FK), `DeletedAt`. UNIQUE (CircleId, RoundId, RecipientId).

## LedgerEntries (append-only)

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| CircleId | uuid | N | FK→Circles |
| RoundId / MemberId | uuid | Y | FKs |
| TransactionType | int | N | Contribution/Payout/Interest/Fee/Adjustment/Reversal/Other |
| Amount | numeric(18,2) | N | CHECK(Amount ≠ 0) |
| BalanceAfter | numeric(18,2) | N | running balance |
| Description | text | Y | |
| ReferenceType / ReferenceId | text/uuid | N/Y | originating entity |
| CorrelationId | uuid | Y | |
| CreatedAt / CreatedBy | timestamptz/uuid | N | |

Never UPDATE/DELETE (BR-FIN-002). Indexes: (CircleId, CreatedAt); (CircleId, MemberId, CreatedAt); (ReferenceType, ReferenceId).

## AuditRecords

`Id` (PK), `ActorId` (FK), `Action` (text), `ResourceType` (text), `ResourceId` (uuid Y), `Timestamp`, `BeforeState`/`AfterState` (jsonb), `CorrelationId` (uuid Y), `Reason` (text Y). Indexes: (ResourceType, ResourceId); (ActorId, Timestamp); (CorrelationId).

## Notifications

`Id` (PK), `UserId` (FK), `Type`, `Title`, `Message`, `ReferenceType`/`ReferenceId`, `Status` (int), `SentAt`, `DeliveredAt`, `CreatedAt`, `ReadAt`.