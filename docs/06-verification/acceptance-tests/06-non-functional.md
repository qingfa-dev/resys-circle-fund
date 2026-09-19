# Acceptance Tests — Non-Functional

```gherkin
Scenario: Atomic financial operation (NFR-004)
  Given a contribution that fails mid-transaction
  Then no partial financial state remains

Scenario: Auth required (NFR-001)
  Given an unauthenticated request to a protected endpoint
  Then the response is 401

Scenario: Exactly-once offline sync (NFR-029)
  Given a queued offline operation
  When it syncs
  Then it is applied exactly once and never silently discarded

Scenario: No secret leakage in errors (NFR-037)
  Given an internal error
  Then the response contains a generic message and correlation ID only
```

## Performance Targets (NFR-007)
- Dashboard ≤ 3s; API read ≤ 2s; normal mutation ≤ 2s; report ≤ 5s.
- Larger exports/imports run as background jobs.

## Acceptance Criteria Format
Given/When/Then; financial stories include offline/sync steps.