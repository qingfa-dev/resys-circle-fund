# ADR-003: Financial Ledger Design

## Status

Accepted

## Context

CircleFund manages real financial transactions for rotating savings groups. The financial history of a circle is critical and must be preserved. Any correction or adjustment to financial records must maintain a complete audit trail.

Several approaches were considered:

1. **Mutable ledger (overwrite):** Update the ledger entry when a correction is needed. Simple but loses history.
2. **Soft delete with history:** Mark records as deleted and keep originals. Better, but requires special queries to see current state.
3. **Append-only with compensating transactions:** Never modify or delete financial records. Corrections are made by creating new entries that reverse or correct the original. Most complex but preserves complete history.

## Decision

CircleFund uses an **append-only financial ledger** with compensating transactions for corrections.

### Ledger Rules

1. **Append-only:** Ledger entries are never updated or deleted once created.
2. **Every financial event creates one or more ledger entries:** Contributions, payouts, interest calculations, fees, adjustments, and reversals all create ledger entries.
3. **Corrections use compensating transactions:** To correct a contribution, a reversal entry is created for the original amount, followed by a correction entry for the new amount.
4. **Each entry references its originating entity:** `ReferenceType` and `ReferenceId` link entries to business entities (Contribution, Payout, Bid, etc.).
5. **Balance is derived:** Member and circle balances are calculated from ledger entries, not stored as mutable values.
6. **Correlation ID on every entry:** All entries within a single operation share a correlation ID for tracing.

### Correction Example

Original contribution of 1,000,000 VND was recorded incorrectly. Correction:

```text
Transaction 1: Ledger entry - Contribution
  Amount: +1,000,000
  Type: Contribution
  Reference: ContributionId = "abc"
  BalanceAfter: 1,000,000

Transaction 2: Ledger entry - Reversal (Correction)
  Amount: -1,000,000
  Type: Reversal
  Description: "Reversing original contribution abc for correction"
  Reference: ContributionId = "abc"
  BalanceAfter: 0

Transaction 3: Ledger entry - Corrected Contribution
  Amount: +950,000
  Type: Contribution
  Description: "Corrected contribution (original was 1,000,000)"
  Reference: ContributionId = "abc"
  BalanceAfter: 950,000
```

### Transaction Boundaries

All ledger entries within a single financial operation must be committed within a single database transaction. If any entry fails, all entries are rolled back.

```text
Begin Transaction
├── Record business entity (e.g., Contribution)
├── Update balance (read model)
├── Create ledger entry 1
├── Create ledger entry 2 (if applicable)
├── Create audit record
└── Commit Transaction
```

### Reversal Entries

Reversals are specific ledger entries that:

- Reference the original transaction being reversed
- Have an opposite-sign amount
- Are clearly labeled with a description explaining why
- Include the original transaction ID in the reference fields
- Are always associated with an audit record

## Consequences

### Positive

- Complete financial history is preserved forever
- Auditors can trace any financial state at any point in time
- Corrections are transparent and traceable
- No data is silently overwritten or lost
- Supports regulatory compliance requirements
- Reconciliation is straightforward (recompute from ledger)

### Negative

- Ledger table grows continuously (mitigated by partitioning/archive strategy)
- Querying "current" state requires considering all entries (mitigated by balance cache)
- More complex correction logic than simple updates
- Database storage requirements grow over time
- Report queries may need to scan many entries for historical views

### Risks

- Large ledger table could impact query performance
- Complex corrections (multi-entry) increase transaction duration
- Accidental creation of incorrect compensating transactions

## Mitigations

- Ledger table partitioning by date/year
- Archive strategy for old entries (move to cold storage, maintain reference)
- Balance read model cache updated on every transaction (denormalized for performance)
- Comprehensive validation of corrections before transaction commit
- Test coverage for all correction scenarios
- Monthly reconciliation job to verify balance cache against ledger
- Database indexes optimized for common queries (member statements, circle summaries)
- Maximum ledger entry size limited per operation (prevent runaway transactions)
