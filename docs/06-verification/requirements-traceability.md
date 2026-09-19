# Requirements Traceability (Verification) — CircleFund

## Purpose

Traces SRS requirements (`docs/01-requirements/srs.md`) through verification, ensuring every requirement is tested and verified before release.

## Iteration 1 → Tests

| Requirement | Unit | Integration | E2E | Verified |
| --- | --- | --- | --- | --- |
| FR-I1-001..007 Identity | TC-I1-001..008 | — | AT-I1-001..006 | ☐ |
| FR-I1-008..014 Circle | TC-I1-009..017 | TC-I1-009..017 | AT-I1-007..013 | ☐ |
| FR-I1-015..020 Round | TC-I1-014..017 | TC-I1-014..017 | — | ☐ |
| FR-I1-021..027 Member/Share | TC-I1-018..027 | TC-I1-018..027 | AT-I1-014..019 | ☐ |
| FR-I1-028..032 Contribution | TC-I1-028..047 | TC-I1-028..047 | AT-I1-020..029 | ☐ |
| FR-I1-033..036 Balance | TC-I1-046..047 | — | AT-I1-030..033 | ☐ |
| FR-I1-037..039 Dashboard | TC-I1-048..051 | — | AT-I1-034..037 | ☐ |
| FR-I1-040..045 Offline/Sync | TC-I1-052..056 | TC-I1-052..056 | AT-I1-038..040 | ☐ |

## Iteration 2 → Tests

| Requirement | Unit | Integration | Verified |
| --- | --- | --- | --- |
| FR-I2-001..005 Payout Draw | TC-I2-001..007 | TC-I2-001..007 | ☐ |
| FR-I2-006..011 Bidding | TC-I2-008..014 | TC-I2-008..014 | ☐ |
| FR-I2-012..020 Rotation/Interest | TC-I2-015..019 | — | ☐ |
| FR-I2-021..024 Reconciliation | TC-I2-020..022 | TC-I2-020..022 | ☐ |
| FR-I2-025..033 Debt/Ledger | TC-I2-023..030 | TC-I2-023..030 | ☐ |
| FR-I2-034..036 P&L | TC-I2-031 | — | ☐ |
| FR-I2-037..039 Audit | TC-I2-032..033 | TC-I2-032..033 | ☐ |
| FR-I2-040..046 Reports/Export | TC-I2-034..035 | TC-I2-034..035 | ☐ |
| FR-I2-047..049 Offline Financial | TC-I2-036..038 | TC-I2-036..038 | ☐ |

## Iterations 3–5 → Tests

| Requirement | Tests | Verified |
| --- | --- | --- |
| FR-I3-001..031 Integrations | TC-I3-001..013 | ☐ |
| FR-I4-001..037 Collaboration | TC-I4-001..021 | ☐ |
| FR-I5-001..031 Platform | TC-I5-001..017 | ☐ |
| NFR-001..040 + §5.41 | Per test strategy | ☐ |

## Completeness Checklist

- [ ] Every FR has at least one test
- [ ] Financial ops have integration + concurrency coverage
- [ ] Every API endpoint has a contract test
- [ ] Every authorization rule has a test
- [ ] Offline/sync scenarios (exactly-once, conflict) tested
- [ ] Idempotency and ledger integrity verified
- [ ] Audit-trail completeness verified