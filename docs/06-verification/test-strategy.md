# Test Strategy — CircleFund

## Overview

Multi-level testing, weighted toward domain/unit tests. Offline/sync and financial correctness are treated as cross-cutting test concerns from Iteration 1, not deferred.

```text
Domain/Unit → Integration → API → Authorization → Concurrency → Offline/Sync → E2E
```

## Test Levels

### Domain / Unit

Scope: pure domain logic. Coverage: business rules (`docs/01-requirements/business-rules.md`), financial calculations (contribution, payout draw, bidding, interest, balance), state transitions, validation, idempotency, money/rounding, debt, reconciliation.

Targets: zero/negative amount, duplicate operation, closed round, missing member, multiple shares, late/partial payment, rounding, same-time updates.

### Integration

Scope: API + Application + Database (isolated test DB). Coverage: endpoint behavior, database state, authorization, validation, error formats, pagination/filtering, idempotency, transaction rollback.

### API Contract

Scope: response/error schemas, status codes, validation/authorization behavior, pagination/sorting/filtering, idempotency headers (OpenAPI-driven).

### Authorization

Explicit tests for every role and resource-ownership rule (NFR-001/002).

### Concurrency

Scenarios: simultaneous contributions for same member/round; simultaneous payout draws; bid races; balance recalculation during contribution. Verifies: no double payout, no duplicate payment, no incorrect balance, no lost update, no inconsistent ledger. Mechanisms: optimistic concurrency, unique constraints, idempotency keys.

### Offline / Sync (Elevated to I1/I2 CI)

```text
Two devices queue conflicting edits to the same share      → resolved, not silently dropped
Two devices queue conflicting financial mutations           → flagged for manual reconciliation
Device goes offline mid-operation, reconnects after delay   → operation completes exactly once
Local ID collides with a since-created server ID            → detected and remapped
```

This test class belongs in the Iteration 1 and 2 CI suite, not a later "offline epic." Acceptance criteria (Given/When/Then) include offline/sync steps for financial stories.

### End-to-End (Playwright)

Key workflows: create account → create circle → add members → generate rounds → record contributions → view balance → dashboard; payout/bidding flow; member statement reconciliation.

## Test Organization

```text
tests/
├── CircleFund.UnitTests/         Domain, Application, Infrastructure
├── CircleFund.IntegrationTests/  Api, Database, Fixtures
├── CircleFund.ApiTests/          Contracts, Authorization, Idempotency, Sync
└── CircleFund.E2ETests/          Workflows, Pages
```

## Financial Calculation Testing

Money edge cases: exact, decimals, large/small, zero (rejected), negative (rejected), rounding policies, interest across rounds. Financial workflow tests: contribution→balance→ledger (atomic); reversal→correction (no overwrite); payout→balance→ledger; bidding→winner→payout→ledger; round close→balance freeze.

## Test Data

Auto-generated/seeded, independent per test, realistic financial values, no real data.

## CI

Every PR: checkout → restore → build → lint/format → unit → integration → API → security scan → publish. Coverage targets: domain >90%, integration >70%, API contract 100%, E2E ~20% (key workflows).

## Naming

`[Method]_[Scenario]_[ExpectedResult]` — e.g., `RecordContribution_DuplicateKey_ReturnsCachedResult`.