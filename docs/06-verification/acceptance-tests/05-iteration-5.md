# Acceptance Tests — Iteration 5 (Advanced Platform)

```gherkin
Scenario: Import never bypasses validation
  Given a data file
  When imported
  Then it is validated, previewed, and confirmed before any mutation
  And row-level errors are reported

Scenario: Transfer is idempotent and ledger-tracked
  Given a transfer between accounts
  Then a ledger record is created
  And retrying the transfer does not duplicate it
```