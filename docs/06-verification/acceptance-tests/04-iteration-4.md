# Acceptance Tests — Iteration 4 (Group Collaboration)

```gherkin
Scenario: Role-based permission enforced
  Given a Circle Member with no financial role
  When they attempt to record a contribution
  Then access is denied

Scenario: Collaboration does not mutate finance
  Given a group message is sent
  When financial state is inspected
  Then no ledger, contribution, payout, or balance changed
```