# Domain Model — Core ROSCA

**Subdomain:** Savings Circle (ROSCA) · Iterations 1–2

## Aggregates & Entities

### Savings Circle (aggregate root)

**Attributes:** `Id`, `Name` (unique per organizer), `AssociationType` (NoInterestRotation | FixedInterest | Bidding), `Status`, `Configuration`, `StartDate`, `CreatedBy`, `CreatedAt`, `UpdatedAt`, `CorrelationId`.

**Configuration:** `ContributionAmount` (decimal), `Frequency` (weekly/biweekly/monthly), `DueDay`, `NumberOfRounds` (int | null indefinite), `NumberOfShares`, `InterestRate` (decimal? FixedInterest), `BiddingRules` (min bid, winner rule), `RoundingStrategy`, `AllowPartialPayment`, `MinMembers(=2)`.

**Status state machine (BR-CIR-002):**

```text
Active → Paused → Active
Active → Closed → Archived
```

Transitions:
- `Active → Paused` — organizer action (no new contributions permitted).
- `Paused → Active` — organizer resumes.
- `Active/Paused → Closed` — only when no open rounds remain; triggers final reconciliation.
- `Closed → Archived` — retention-driven move.
- **Forbidden:** contributions in `Closed`/`Archived`; closing while rounds are open.

**Invariants:** single organizer at all times (BR-CIR-001); ≥2 members before first round opens (BR-CIR-005); name unique per organizer (BR-CIR-003).

### Round

**Attributes:** `Id`, `CircleId`, `RoundNumber` (sequential), `ScheduledDate`, `Status`, `OpenedAt`, `CompletedAt`, `ClosedAt`, `CorrelationId`.

**Lifecycle (FR-I1-018):**

```text
Scheduled → Open → Completed → Closed
Scheduled/Pending/Open → Cancelled (exceptions)
```

- `Scheduled → Open`: organizer opens the round.
- `Open → Completed`: all due contributions recorded; system validates before completing.
- `Completed → Closed`: final freeze.
- **Forbidden:** recording contributions against `Closed`/`Cancelled`; adjusting date once not `Scheduled` (FR-I1-020).

### Member

**Attributes:** `Id`, `UserId`, `CircleId`, `Status` (Active | Suspended | Removed | Completed), `JoinedAt`, `RemovedAt`.

**State machine (BR-MEM-002):**

```text
Active → Suspended → Active
Active → Removed
```

- Suspended members cannot contribute but retain share assignments.

### Share

**Attributes:** `Id`, `CircleId`, `MemberId`, `ShareNumber`, `Status` (Active | Transferred), `AssignedAt`.

**Invariants:** `ShareNumber` unique per circle; shares assigned before first round opens (BR-MEM-003); transfer traceable (BR-MEM-004).

### Contribution

**Attributes:** `Id`, `CircleId`, `RoundId`, `MemberId`, `ShareId`, `Amount` (> 0), `DueDate`, `PaymentDate`, `PaymentMethod`, `Reference`, `Status`, `IdempotencyKey`, `RecordedBy`, `RecordedAt`, `CorrelationId`.

**Status machine (BR-CON-004):**

```text
Unpaid → Partial → Paid
Unpaid/Partial → Overdue        (past deadline)
Unpaid/Partial → Waived         (authorized)
any → Cancelled                 (authorized)
```

**Invariants:** one per member/share/round (BR-CON-003); amount matches configured or valid partial (BR-CON-001); corrections via compensating entries (BR-CON-005).

### Bid

**Attributes:** `Id`, `CircleId`, `RoundId`, `MemberId`, `Amount` (> 0), `SubmittedAt`, `Status` (Active | Replaced | Cancelled), `ReplacedById`.

**Rules (BR-BID-*):** only while bidding open; meets minimum; winner by configured rule; new bid replaces prior (prior preserved).

### Payout Draw → Payout

**Attributes:** `Id`, `CircleId`, `RoundId`, `RecipientId`, `GrossAmount`, `InterestAmount`, `DiscountAmount`, `NetAmount` (≤ Gross), `PayoutDate`, `PayoutMethod`, `Status`, `RecordedBy`, `ReversedById`, `CorrelationId`.

**Rules (BR-PAY-*):** eligibility check; single recipient per round; rotation order respected.

### Ledger Entry (append-only)

**Attributes:** `Id`, `CircleId`, `RoundId?`, `MemberId?`, `TransactionType`, `Amount` (≠0), `BalanceAfter`, `Description`, `ReferenceType`, `ReferenceId`, `CorrelationId`, `CreatedAt`, `CreatedBy`.

**Rules (BR-FIN-002):** never modified/deleted; corrections are compensating entries; each references its originating operation (FR-I2-030).

### Audit Record

**Attributes:** `Id`, `ActorId`, `Action`, `ResourceType`, `ResourceId`, `Timestamp`, `BeforeState` (jsonb), `AfterState` (jsonb), `CorrelationId`, `Reason` (BR-AUD-002).

## Domain Events

`CircleCreated`, `CircleStatusChanged`, `MemberAdded`, `MemberStatusChanged`, `ShareAssigned`, `RoundGenerated`, `RoundStatusChanged`, `ContributionRecorded`, `ContributionReversed`, `PayoutRecorded`, `PayoutReversed`, `BidRecorded`, `WinnerDetermined`, `LedgerEntryCreated`, `AuditRecordCreated`, `BalanceRecalculated`.