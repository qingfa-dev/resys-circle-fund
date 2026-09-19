# Requirements Traceability (Verification) — CircleFund

## Purpose

This document traces requirements from the SRS through verification activities (tests) to ensure every requirement is tested and verified before release.

## Traceability Matrix

The matrix below maps each requirement to its corresponding test cases and verification status.

### Iteration 1 Requirements → Tests

| SRS Requirement | Design Item | Implementation | Unit Test | Integration Test | E2E Test | Verified |
|-----------------|-------------|----------------|-----------|-----------------|----------|----------|
| FR-I1-001 Account Registration | | | TC-I1-001, TC-I1-002 | | AT-I1-001 | ☐ |
| FR-I1-002 Account Verification | | | TC-I1-001 | | AT-I1-001 | ☐ |
| FR-I1-003 Authentication | | | TC-I1-004, TC-I1-005 | | AT-I1-002, AT-I1-004 | ☐ |
| FR-I1-004 Logout | | | | | AT-I1-004 | ☐ |
| FR-I1-005 Password Recovery | | | TC-I1-005 | | AT-I1-002 | ☐ |
| FR-I1-006 Profile Management | | | | | AT-I1-003 | ☐ |
| FR-I1-007 Application Lock | | | | | | ☐ |
| FR-I1-008 Create Circle | | | TC-I1-009, TC-I1-010 | | AT-I1-007 | ☐ |
| FR-I1-009 Support Circle Types | | | | | | ☐ |
| FR-I1-010 View Circle | | | | | AT-I1-007 | ☐ |
| FR-I1-011 Edit Circle | | | | | AT-I1-007 | ☐ |
| FR-I1-012 Pause Circle | | | | | AT-I1-007 | ☐ |
| FR-I1-013 Close Circle | | | | | AT-I1-007 | ☐ |
| FR-I1-014 Archive Circle | | | | | AT-I1-007 | ☐ |
| FR-I1-015 Generate Periods | | | TC-I1-028, TC-I1-029 | | AT-I1-007 | ☐ |
| FR-I1-016-020 Period Features | | | TC-I1-030-033 | | | ☐ |
| FR-I1-021-027 Member/Share Features | | | TC-I1-018-025 | | AT-I1-014-019 | ☐ |
| FR-I1-028-032 Contribution Features | | | TC-I1-034-037 | TC-I1-034 | AT-I1-020-029 | ☐ |
| FR-I1-033-036 Balance Features | | | TC-I1-026-027, TC-I1-030 | | AT-I1-030-033 | ☐ |
| FR-I1-037-039 Dashboard/Notifications | | | TC-I1-048-050 | | AT-I1-034-037 | ☐ |

### Iteration 1 Authorization → Tests

| SRS Requirement | API Test | E2E Test | Verified |
|----------------|----------|----------|----------|
| Auth required for all endpoints | TC-I1-052 | | ☐ |
| Organizer permissions | TC-I1-055, TC-I1-057 | | ☐ |
| Member permissions | TC-I1-053, TC-I1-054 | | ☐ |
| Treasurer permissions | TC-I1-057 | | ☐ |
| Viewer permissions | TC-I1-058 | | ☐ |

### Iteration 2 Requirements → Tests

| SRS Requirement | Unit Test | Integration Test | E2E Test | Verified |
|----------------|-----------|-----------------|----------|----------|
| FR-I2-001-005 Payouts | TC-I2-001-003 | TC-I2-001, TC-I2-004-006 | AT-I2-001 | ☐ |
| FR-I2-006-011 Bidding | TC-I2-008-010 | TC-I2-008, TC-I2-011-012, TC-I2-015 | AT-I2-007-013 | ☐ |
| FR-I2-012-016 Rotation/Lottery | TC-I2-018-020 | TC-I2-019 | AT-I2-008-010 | ☐ |
| FR-I2-017-020 Interest | TC-I2-016-017 | | | ☐ |
| FR-I2-021-024 Reconciliation | TC-I2-021-023 | TC-I2-024-026 | AT-I2-018 | ☐ |
| FR-I2-025-028 Debt | TC-I2-021-023 | | | ☐ |
| FR-I2-029-033 Ledger | TC-I2-027-029, TC-I2-031-034 | TC-I2-027-031 | AT-I2-014-017 | ☐ |
| FR-I2-034-036 P&L | TC-I2-021-023 | | AT-I2-018 | ☐ |
| FR-I2-037-039 Audit | TC-I2-036-038 | TC-I2-036-042 | AT-I2-014-017 | ☐ |
| FR-I2-040-043 Reports | TC-I2-043-045 | TC-I2-043-044 | AT-I2-018 | ☐ |
| FR-I2-044-046 Export | | TC-I2-045-046 | AT-I2-018 | ☐ |

### Verification Completeness Checklist

- [ ] Every functional requirement has at least one unit test
- [ ] Every financial operation has integration test coverage
- [ ] Every API endpoint has API contract test
- [ ] Key workflows have E2E test coverage
- [ ] Every authorization rule has a corresponding test
- [ ] Business rules from `docs/01-requirements/business-rules.md` are all tested
- [ ] Edge cases are tested (zero amounts, negative amounts, concurrent operations)
- [ ] Idempotency is tested
- [ ] Ledger integrity is verified
- [ ] Audit trail completeness is verified
