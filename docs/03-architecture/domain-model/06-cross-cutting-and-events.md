# Domain Model — Cross-Cutting Concepts & Events

## Money

- Fixed-precision `decimal` (128-bit); never floating-point (BR-FIN-001).
- Currency default VND; precision 2 decimals; rounding half-up applied at the final step only (BR-FIN-007).
- Centralized monetary policy shared by all calculations.

## Balance

- Derived, never stored mutable (BR-FIN-003).
- `MemberBalance = Σ LedgerEntries(member, circle)`.
- Round collection = count/sum of contributions per round.
- Circle balance = aggregate of member balances.
- Pending-sync/conlict records excluded from authoritative reads (FR-I2-049).

## Idempotency

- Every financial mutation keyed by `IdempotencyKey` (UUID).
- Server stores key → response; duplicate key returns cached result (NFR-006, ADR-004).
- Required for: contributions, payouts, transfers, imports, synchronization, AI-confirmed transactions.

## Correlation ID

- Traces a logical operation across entities, ledger entries, audit records, logs, and events.
- Enables end-to-end investigation of a business transaction.

## Compensating Transactions

- Corrections never overwrite/delete (ADR-003).
- Pattern: original entry + reversal entry (opposite sign) + correction entry.
- Balance recomputed from the full, append-only history.

## Domain Event Catalog

| Event | Trigger |
| --- | --- |
| CircleCreated / CircleStatusChanged | circle create / status |
| MemberAdded / MemberStatusChanged | membership changes |
| ShareAssigned | share assignment |
| RoundGenerated / RoundStatusChanged | round lifecycle |
| ContributionRecorded / ContributionReversed | payments |
| PayoutRecorded / PayoutReversed | payout draw / correction |
| BidRecorded / WinnerDetermined | bidding |
| LedgerEntryCreated | financial entry |
| AuditRecordCreated | audit trail |
| BalanceRecalculated | balance refresh |
| OperationQueued / OperationSyncing / OperationSynced / SyncConflictDetected / SyncConflictResolved | offline/sync |
| NotificationRequested / NotificationDelivered / NotificationFailed | I3 notifications |
| AIProposalCreated / AIProposalConfirmed / AIProposalRejected | I3 AI |