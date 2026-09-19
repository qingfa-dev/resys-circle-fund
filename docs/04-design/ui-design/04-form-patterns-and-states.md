# UI Design — Form Patterns & UX States

## Financial Form Confirmation
1. Show summary of all data (circle, member, round, amount, date, method).
2. Require explicit confirmation (button, never auto-submit).
3. Show idempotency state ("this will create a new transaction").
4. Show estimated balance impact (e.g., "+1,000,000 VND to Member A").
5. Re-authenticate for amounts above configurable threshold.

## Field Validation
- Amount: numeric, `> 0`, ≤ 2 decimals; inline error.
- Date: ISO, not in future; inline error.
- Member/Share/Round: must exist and be active; disabled otherwise.
- Cross-field: period open, member active, no duplicate (BR-CON-001/003).

## Form States

```text
Loading     → button spinner, form disabled
Validation  → field-level red border + message; form-level error banner
Duplicate   → "already recorded" (idempotency) + link to existing record
Success     → confirmation dialog → navigate (or "add another")
Error       → clear message + retry
Offline     → "pending sync" note; queued rather than blocked
```

## UX States (every screen)

| State | Behavior |
| --- | --- |
| Normal | expected data |
| Loading | skeleton / spinner |
| Empty | guidance + primary action |
| Validation | field errors |
| Error | retry |
| Success | confirmation |
| Permission denied | message + help link |
| Offline | cached data + sync chip |
| Conflict | both versions + resolve |
| Pending-sync | amber chip, excluded from totals |