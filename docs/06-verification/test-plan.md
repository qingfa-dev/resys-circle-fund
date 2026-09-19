# Test Plan — CircleFund

## Overview

This test plan defines the testing approach for each iteration and release. All tests from the test strategy are organized here by feature and iteration.

## Test Categories

| Category | Tool | Scope | Execution |
|----------|------|-------|-----------|
| Unit Tests | xUnit | Domain logic, business rules | Fast, every commit |
| Integration Tests | xUnit + WebApplicationFactory | API + DB | CI pipeline |
| API Contract Tests | Custom + FluentAssertions | API schemas, auth | CI pipeline |
| E2E Tests | Playwright | UI workflows | Nightly or pre-release |
| Performance Tests | Benchmarks (progressive) | Critical paths | Pre-release |
| Security Tests | Dependency scanner, manual | All endpoints | Pre-release |

## Test Plan — Iteration 1

### Identity & Account Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-001 | Registration with valid data | Integration | Registration |
| TC-I1-002 | Registration with duplicate email | Integration | Registration |
| TC-I1-003 | Registration with weak password | Integration | Registration |
| TC-I1-004 | Login with valid credentials | Integration | Login |
| TC-I1-005 | Login with invalid password | Integration | Login |
| TC-I1-006 | Token refresh flow | Integration | Auth |
| TC-I1-007 | Profile update | Integration | Profile |
| TC-I1-008 | Logout invalidates session | Integration | Logout |

### Savings Circle Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-009 | Create circle with valid data | Integration | Create Circle |
| TC-I1-010 | Create circle with missing required fields | Integration | Create Circle |
| TC-I1-011 | Create circle with duplicate name | Integration | Create Circle |
| TC-I1-012 | Edit circle configuration | Integration | Edit Circle |
| TC-I1-013 | Pause/activate circle | Integration | Circle Status |
| TC-I1-014 | Close circle (non-empty) | Integration | Close Circle |
| TC-I1-015 | Close circle (empty) | Integration | Close Circle |
| TC-I1-016 | Get circle details | Integration | Get Circle |
| TC-I1-017 | List circles with filtering | Integration | List Circles |

### Member & Share Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-018 | Add member with valid data | Integration | Add Member |
| TC-I1-019 | Add duplicate member (same user in same circle) | Integration | Add Member |
| TC-I1-020 | Add member to non-existent circle | Integration | Add Member |
| TC-I1-021 | Assign single share | Integration | Assign Share |
| TC-I1-022 | Assign multiple shares | Integration | Assign Share |
| TC-I1-023 | Transfer share | Integration | Transfer Share |
| TC-I1-024 | Suspend member | Integration | Member Status |
| TC-I1-025 | Remove member with contributions | Integration | Remove Member |
| TC-I1-026 | Member balance after contribution | Unit | Balance Calculation |
| TC-I1-027 | Member balance after payout (negative) | Unit | Balance Calculation |

### Period Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-028 | Generate periods with valid schedule | Integration | Generate Periods |
| TC-I1-029 | Generate periods with invalid schedule | Integration | Generate Periods |
| TC-I1-030 | Open/close period lifecycle | Integration | Period Status |
| TC-I1-031 | Period number auto-increment | Unit | Period Generation |
| TC-I1-032 | Edit period date before opening | Integration | Edit Period |
| TC-I1-033 | Cannot edit closed period | Integration | Edit Period |

### Contribution Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-034 | Record contribution with valid data | Integration | Record Contribution |
| TC-I1-035 | Record contribution with zero amount | Unit | Contribution Validation |
| TC-I1-036 | Record contribution with negative amount | Unit | Contribution Validation |
| TC-I1-037 | Record duplicate contribution (idempotency) | Integration | Idempotency |
| TC-I1-038 | Record contribution for closed period | Unit | Contribution Validation |
| TC-I1-039 | Record contribution for inactive member | Unit | Contribution Validation |
| TC-I1-040 | Record contribution with concurrency (2 simultaneous) | Concurrency | Duplicate Prevention |
| TC-I1-041 | Verify balance after contribution | Unit | Balance Calculation |
| TC-I1-042 | View payment status | Integration | Payment Status |
| TC-I1-043 | Contribution history per member | Integration | Contribution History |
| TC-I1-044 | Correct contribution (reversal + correction) | Integration | Correction |
| TC-I1-045 | Correct contribution does not overwrite original | Integration | Ledger Audit |
| TC-I1-046 | Partial payment accepted | Integration | Partial Payment |
| TC-I1-047 | Overdue payment detected | Unit | Payment Status |

### Dashboard Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-048 | Dashboard shows active circles | Integration | Dashboard |
| TC-I1-049 | Dashboard shows upcoming periods | Integration | Dashboard |
| TC-I1-050 | Dashboard shows unpaid contributions count | Integration | Dashboard |
| TC-I1-051 | Dashboard shows correct balance summary | Unit | Balance Calculation |

### Authorization Tests (I1)

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I1-052 | Unauthenticated user cannot create circle | API | Authorization |
| TC-I1-053 | Regular user cannot create circle | API | Authorization |
| TC-I1-054 | Member cannot edit circle settings | API | Authorization |
| TC-I1-055 | Organizer can edit own circle | API | Authorization |
| TC-I1-056 | Non-member cannot view circle | API | Authorization |
| TC-I1-057 | Treasurer can record contribution | API | Authorization |
| TC-I1-058 | Viewer cannot record contribution | API | Authorization |

## Test Plan — Iteration 2

### Hốt (Payout) Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-001 | Record payout with valid data | Integration | Payout |
| TC-I2-002 | Payout amount exceeds collected amount | Unit | Payout Validation |
| TC-I2-003 | Payout for ineligible member | Unit | Payout Validation |
| TC-I2-004 | Multiple payouts for same period prevented | Concurrency | Payout Conflict |
| TC-I2-005 | Payout reversal | Integration | Payout Reversal |
| TC-I2-006 | Payout ledger entry created | Integration | Ledger |
| TC-I2-007 | Payout updates member balance | Unit | Balance Calculation |

### Bidding Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-008 | Place valid bid | Integration | Bidding |
| TC-I2-009 | Bid below minimum amount | Unit | Bidding Validation |
| TC-I2-010 | Bid for non-open period | Unit | Bidding Validation |
| TC-I2-011 | Multiple bids by same member (last wins) | Integration | Bidding |
| TC-I2-012 | Determine winner with bids | Integration | Winner Determination |
| TC-I2-013 | Determine winner with no bids | Unit | Winner Determination |
| TC-I2-014 | Winner determination requires open bids | Unit | Bidding Validation |
| TC-I2-015 | Bid history preserved | Integration | Bidding |

### Interest / Rotation / Lottery Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-016 | Fixed interest calculation | Unit | Interest Calculation |
| TC-I2-017 | Interest rate changes don't affect history | Unit | Interest Calculation |
| TC-I2-018 | Rotation order maintained | Unit | Rotation Logic |
| TC-I2-019 | Lottery result recorded | Integration | Lottery |
| TC-I2-020 | No member selected twice (if configured) | Unit | Rotation Validation |

### Reconciliation Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-021 | Reconciliation with all contributions paid | Unit | Reconciliation |
| TC-I2-022 | Reconciliation detects missing contributions | Unit | Reconciliation |
| TC-I2-023 | Reconciliation detects excess payments | Unit | Reconciliation |
| TC-I2-024 | Reconciliation adjustment recorded | Integration | Reconciliation |
| TC-I2-025 | Unauthorized adjustment rejected | API | Authorization |
| TC-I2-026 | Reconciliation results match ledger | Unit | Ledger Verification |

### Ledger Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-027 | Ledger entry created for contribution | Integration | Ledger |
| TC-I2-028 | Ledger entry created for payout | Integration | Ledger |
| TC-I2-029 | Ledger entry created for reversal | Integration | Ledger |
| TC-I2-030 | Ledger entries never deleted | Integration | Ledger Integrity |
| TC-I2-031 | Ledger entries never modified | Integration | Ledger Integrity |
| TC-I2-032 | Member statement generated from ledger | Integration | Ledger |
| TC-I2-033 | Ledger balance matches sum of entries | Unit | Ledger Verification |
| TC-I2-034 | Ledger entries reference originating entity | Integration | Ledger |
| TC-I2-035 | Ledger includes correlation ID | Integration | Ledger |

### Audit Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-036 | Contribution recorded → audit entry created | Integration | Audit |
| TC-I2-037 | Circle configuration changed → audit entry | Integration | Audit |
| TC-I2-038 | Member status changed → audit entry | Integration | Audit |
| TC-I2-039 | Audit includes before/after state | Integration | Audit |
| TC-I2-040 | Audit includes correlation ID | Integration | Audit |
| TC-I2-041 | Audit search by actor | Integration | Audit |
| TC-I2-042 | Audit search by resource | Integration | Audit |

### Reports & Export Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-043 | Circle summary report generated | Integration | Reports |
| TC-I2-044 | Member statement generated | Integration | Reports |
| TC-I2-045 | CSV export generated correctly | Integration | Export |
| TC-I2-046 | Excel export generated correctly | Integration | Export |
| TC-I2-047 | Export respects authorization | API | Authorization |
| TC-I2-048 | Report numbers match ledger | Unit | Report Verification |

### Authorization Tests (I2)

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I2-049 | Member cannot determine bid winner | API | Authorization |
| TC-I2-050 | Member cannot start reconciliation | API | Authorization |
| TC-I2-051 | Non-treasurer cannot record payout | API | Authorization |
| TC-I2-052 | Organizer can close period | API | Authorization |
| TC-I2-053 | Viewer can view reports | API | Authorization |
| TC-I2-054 | Viewer cannot export data | API | Authorization |

## Test Plan — Iteration 3

### Group & Roles Tests

| Test ID | Test | Level | Feature |
|---------|------|-------|---------|
| TC-I3-001 | Create group | Integration | Group |
| TC-I3-002 | Invite member to group | Integration | Group |
| TC-I3-003 | Invitee accepts invitation | Integration | Group |
| TC-I3-004 | Invitee rejects invitation | Integration | Group |
| TC-I3-005 | Assign role to member | Integration | Roles |
| TC-I3-006 | Remove role from member | Integration | Roles |
| TC-I3-007 | Role-based authorization enforced | API | Authorization |
| TC-I3-008 | Permission changes are audited | Integration | Audit |

### Other I3 Tests (similar structure for each feature)

- Announcements CRUD and visibility
- Voting creation, casting, and counting
- Rules creation, versioning, and auditing
- Fines and appeals workflows
- Chat and messaging
- Meetings and attendance
- Task creation and tracking

## Test Data

All test data is auto-generated or seeded. No real financial data is used. Test data files are maintained separately and versioned with the test suite.

## Test Maintenance

- Failing tests are fixed within 24 hours (CI blocks merge)
- Flaky tests are quarantined and fixed within 1 sprint
- Outdated tests are updated or removed
- Test coverage is tracked and reported in CI
