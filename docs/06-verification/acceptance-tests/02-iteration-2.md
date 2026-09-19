# Acceptance Tests — Iteration 2 (Financial Operations)

```gherkin
Scenario: Record payout draw
  Given an eligible member in an open round
  When a payout draw is recorded
  Then the net payout is calculated from contributions and discount/interest
  And a ledger entry is created

Scenario: Payout single recipient per round
  Given a payout already recorded for a round
  When a second payout is attempted for the same round
  Then it is rejected

Scenario: Reversal preserves original
  Given a recorded payout
  When it is reversed
  Then the original entry remains unchanged
  And a reversal entry is appended

Scenario: Offline payout draw is pending
  Given a payout draw recorded while offline
  When balances, ledger, or reports are viewed
  Then the pending record is visibly marked and excluded from totals

Scenario: Conflicting offline payout draw escalates
  Given two devices record a payout draw for the same round offline
  When they sync
  Then the conflict is flagged for manual reconciliation (never auto-merged)

Scenario: Concurrent duplicate operation processed once
  Given two identical financial requests with the same idempotency key
  When both arrive concurrently
  Then only one is applied
```