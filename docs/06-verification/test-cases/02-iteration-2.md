# Test Cases — Iteration 2 (Financial Operations)

## Payout Draw

| ID | Scenario | Steps | Expected |
| --- | --- | --- | --- |
| TC-I2-001 | Record valid payout draw | open eligible member → submit | 200; payout + ledger entry |
| TC-I2-002 | Ineligible member | non-member / suspended | 422 |
| TC-I2-003 | Net > collected | amount exceeds pool | 422 |
| TC-I2-004 | Duplicate payout same round/recipient | 2nd submit | 409 unique |
| TC-I2-005 | Reversal | reverse payout | original preserved + reversal entry |
| TC-I2-006 | Balance effect | after payout | member balance decreased |

## Bidding

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I2-007 | Place valid bid | 200 |
| TC-I2-008 | Bid below minimum | 422 |
| TC-I2-009 | Bid on closed round | 422 |
| TC-I2-010 | Winner with bids | highest (configured) selected |
| TC-I2-011 | Winner with no bids | error / no winner |
| TC-I2-012 | Duplicate bid | new replaces old (history kept) |

## Rotation / Interest / Reconciliation / Debt

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I2-013..014 | Rotation order; no double selection | order enforced |
| TC-I2-015..016 | Fixed interest; rate change historic | history immutable |
| TC-I2-017..019 | Reconciliation: all paid / missing / excess | correct discrepancy |
| TC-I2-020 | Unauthorized adjustment | 403 |
| TC-I2-021..022 | Debt view + aging | correct |

## Ledger / P&L / Audit / Reports / Export

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I2-023..026 | Ledger entry per op; never update/delete | append-only |
| TC-I2-027 | Statement from ledger | matches Σ |
| TC-I2-028..029 | Estimated / actual P&L | correct |
| TC-I2-030..031 | Audit content + search | who/what/when/resource/before/after |
| TC-I2-032..034 | Reports + CSV/Excel + auth | correct + authorization |

## Offline-Aware Financial Handling

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I2-035 | Offline financial mutation | uses local-ID/queue (FR-I2-047) |
| TC-I2-036 | Conflicting offline payout draw | manual reconciliation (no auto-merge) |
| TC-I2-037 | Pending-sync financial record | excluded from balance/ledger/report |

## Concurrency

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I2-038 | Two identical contributions (same key) | processed once |
| TC-I2-039 | Two payouts same round simultaneously | one succeeds, one 409 |
| TC-I2-040 | Concurrent different contributions | balance = sum |