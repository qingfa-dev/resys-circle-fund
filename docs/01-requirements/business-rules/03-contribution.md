# Contribution Rules — Business Rules

**Category:** Contribution

## BR-CON-001 — Amount
Must match the configured amount or be a valid partial payment (if allowed).

## BR-CON-002 — Deadline
Contributions due by the round's configured deadline; overdue contributions tracked.

## BR-CON-003 — Duplicate Prevention
One contribution per member per share per round; duplicates rejected.

## BR-CON-004 — States
`Unpaid, Partial, Paid, Overdue, Waived, Cancelled`.

## BR-CON-005 — Correction
Corrections use compensating (reversal + correction) entries, never overwrite.