# Financial Rules — Business Rules

**Category:** Financial

## BR-FIN-001 — Fixed Precision
Monetary calculations use fixed-precision decimal; never floating-point.

## BR-FIN-002 — Append-Only Ledger
Entries never modified/deleted; corrections are compensating entries.

## BR-FIN-003 — Derived Balance
Balances derived from ledger, not stored mutable totals.

## BR-FIN-004 — Atomicity
Multi-record financial operations commit or roll back as one transaction.

## BR-FIN-005 — Idempotency
Financial mutations require idempotency keys.

## BR-FIN-006 — Interest
Calculated from configured rate and round parameters; historical results unaffected by later config changes.

## BR-FIN-007 — Rounding
Applied at the final step (half-up default), not intermediate steps.