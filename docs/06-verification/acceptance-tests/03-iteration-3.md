# Acceptance Tests — Iteration 3 (Integrations)

```gherkin
Scenario: Failed notification does not roll back
  Given a committed contribution
  When the notification delivery fails
  Then the contribution remains committed

Scenario: AI proposes before commit
  Given a natural-language payment instruction
  When the AI interprets it
  Then a proposed transaction is shown
  And nothing is committed until the user confirms

Scenario: Backup failure is alerted
  Given a scheduled backup fails
  Then the failure is detected and alerted (not silently skipped)
```