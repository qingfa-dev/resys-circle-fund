# Acceptance Tests — CircleFund

## Overview

Acceptance tests verify that the system meets business requirements from the user's perspective. They are written against acceptance criteria in user stories and SRS requirements.

## Test Categories

### Category 1: Core Circle Workflows (I1)

#### Registration and Authentication

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I1-001 | User can register | 1. Navigate to register 2. Enter valid details 3. Submit | Account created, verification email sent |
| AT-I1-002 | Registration rejects duplicate email | 1. Register with email 2. Register again with same email | Error: email already exists |
| AT-I1-003 | Password policy enforced | 1. Register with weak password 2. Submit | Error: password does not meet requirements |
| AT-I1-004 | Authenticated user can login | 1. Enter valid credentials 2. Submit | Redirect to dashboard |
| AT-I1-005 | Invalid credentials rejected | 1. Enter wrong password 2. Submit | Error: invalid credentials |
| AT-I1-006 | User can logout | 1. Click logout | Session ended, redirect to login |

#### Circle Management

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I1-007 | Organizer can create circle | 1. Login as organizer 2. Navigate to create circle 3. Enter valid data 4. Submit | Circle created, listed in dashboard |
| AT-I1-008 | Circle creation rejects missing required fields | 1. Create circle with empty name 2. Submit | Validation error displayed |
| AT-I1-009 | Circle creation rejects duplicate name | 1. Create circle "Test" 2. Create another "Test" | Error: name already exists |
| AT-I1-010 | Organizer can edit circle settings | 1. Open circle 2. Edit configuration 3. Save | Changes persisted |
| AT-I1-011 | Organizer can pause circle | 1. Open circle settings 2. Pause 3. Confirm | Circle status = Paused, no new contributions allowed |
| AT-I1-012 | Organizer can close circle | 1. Close circle (no open periods) 2. Confirm | Circle status = Closed, no further operations |
| AT-I1-013 | Archived circle viewable in history | 1. Navigate to archived circles 2. Select circle | Circle details displayed |

#### Member Management

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I1-014 | Organizer can add member | 1. Open circle 2. Add member with valid data 3. Save | Member added to circle |
| AT-I1-015 | Add member rejects duplicate membership | 1. Add existing member 2. Save | Error: member already in circle |
| AT-I1-016 | Organizer can assign share | 1. Open member 2. Assign share 3. Save | Share recorded |
| AT-I1-017 | Organizer can suspend member | 1. Open member 2. Suspend 3. Confirm | Member status = Suspended |
| AT-I1-018 | Suspended member cannot contribute | 1. Login as suspended member 2. Attempt contribution | Error: account suspended |
| AT-I1-019 | Organizer can remove member | 1. Open member 2. Remove 3. Confirm | Member removed from circle |

#### Contribution Workflow

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I1-020 | Organizer can record contribution | 1. Open contribution form 2. Enter valid data 3. Confirm | Contribution recorded, balance updated |
| AT-I1-021 | Contribution rejected for zero amount | 1. Enter amount = 0 2. Submit | Validation error |
| AT-I1-022 | Contribution rejected for negative amount | 1. Enter amount = -100 2. Submit | Validation error |
| AT-I1-023 | Duplicate contribution prevented | 1. Record contribution 2. Submit same again (new attempt) | Error: duplicate detected or same result |
| AT-I1-024 | Balance updated after contribution | 1. Record contribution 2. Check member balance | Balance increased by contribution amount |
| AT-I1-025 | Ledger entry created after contribution | 1. Record contribution 2. Check ledger | New entry visible with correct amount and type |
| AT-I1-026 | Contribution recorded for inactive member rejected | 1. Select inactive member 2. Submit | Error: member not active |
| AT-I1-027 | Contribution recorded for closed period rejected | 1. Select closed period 2. Submit | Error: period not open |
| AT-I1-028 | Payment status updated after contribution | 1. Check payment status before 2. Record contribution 3. Check again | Status changed from Unpaid to Paid |
| AT-I1-029 | Contribution history visible | 1. View contribution history | All contributions listed with details |

#### Balance Workflow

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I1-030 | Member balance shown correctly | 1. Record 3 contributions of 1M each 2. Check balance | Balance = 3,000,000 VND |
| AT-I1-031 | Period balance shows collection progress | 1. Open circle with 5 members 2. 3 paid, 2 unpaid 3. Check period balance | Collected: 3/5 |
| AT-I1-032 | Balance recalculation consistent | 1. Record contributions 2. Trigger recalculation 3. Compare | Balance matches sum of ledger entries |
| AT-I1-033 | Payout reduces member balance | 1. Record payout for member 2. Check balance | Balance decreased by payout amount |

#### Dashboard

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I1-034 | Dashboard shows all active circles | 1. Login 2. View dashboard | All circles listed |
| AT-I1-035 | Dashboard shows upcoming periods | 1. View dashboard | Upcoming periods visible |
| AT-I1-036 | Dashboard shows unpaid contributions | 1. View dashboard | Unpaid count shown |
| AT-I1-037 | Dashboard shows correct financial summary | 1. View dashboard | Totals match database |

### Category 2: Financial Workflows (I2)

#### Payout Workflow

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I2-001 | Organizer can record payout for open period | 1. Open period 2. Record payout 3. Confirm | Payout recorded, ledger updated |
| AT-I2-002 | Payout for ineligible member rejected | 1. Select non-member 2. Submit payout | Error: not eligible |
| AT-I2-003 | Payout exceeding collected amount rejected | 1. Set amount > collected 2. Submit | Error: insufficient funds |
| AT-I2-004 | Payout creates ledger entry | 1. Record payout 2. Check ledger | Entry with type Payout and correct amount |
| AT-I2-005 | Payout reversal creates reversal entry | 1. Reverse payout 2. Check ledger | Reversal entry, original preserved |
| AT-I2-006 | Only one payout per period per member | 1. Attempt second payout for same member/period | Error: payout already recorded |

#### Bidding Workflow

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I2-007 | Eligible member can place bid | 1. Open bidding 2. Place bid above minimum 3. Confirm | Bid recorded |
| AT-I2-008 | Bid below minimum rejected | 1. Place bid below minimum 2. Submit | Error: below minimum |
| AT-I2-009 | Bid for closed period rejected | 1. Select closed period 2. Place bid | Error: period not open for bidding |
| AT-I2-010 | Winner determined from bids | 1. Place 3 bids 2. Determine winner | Highest bidder selected |
| AT-I2-011 | Winner determination creates ledger entries | 1. Determine winner 2. Check ledger | Payout and balance entries created |
| AT-I2-012 | Bid history preserved | 1. Place bids 2. View bid history | All bids listed |
| AT-I2-013 | New bid replaces old bid (recorded, not deleted) | 1. Place bid 2. Place new bid 3. View bid history | Both bids visible, newest active |

#### Ledger Verification

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I2-014 | All financial operations create ledger entries | 1. Perform contribution, payout, bid 2. Check ledger | Entries for all operations |
| AT-I2-015 | Original ledger entries never modified | 1. Correct a contribution 2. Check original entry | Original entry unchanged |
| AT-I2-016 | Ledger entries preserve timestamps | 1. Check entry timestamps | Accurate timestamps |
| AT-I2-017 | Member statement matches ledger | 1. Generate statement 2. Compare to ledger | Numbers match |
| AT-I2-018 | Reconciliation verifies ledger consistency | 1. Run reconciliation 2. Review results | Expected matches actual |

#### Concurrency Verification

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I2-019 | Two contributions for same member/period only processed once | 1. User A submits contribution 2. User B submits same (same idempotency key) 3. Check | Only one contribution recorded |
| AT-I2-020 | Concurrent payouts rejected | 1. Start payout A 2. Simultaneously start payout B for same data 3. Check | One succeeds, one rejected |
| AT-I2-021 | Balance correct after concurrent contributions | 1. Two users simultaneously contribute different amounts 2. Check balance | Balance = sum of both contributions |

### Category 3: Group Collaboration (I3)

#### Group Management

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I3-001 | User can create group | 1. Navigate to groups 2. Create with valid data 3. Submit | Group created |
| AT-I3-002 | Group owner can invite members | 1. Open group 2. Invite by email 3. Save | Invitation sent |
| AT-I3-003 | Invitee can accept invitation | 1. Open invitation 2. Accept | Membership created |
| AT-I3-004 | Invitee can reject invitation | 1. Open invitation 2. Reject | Invitation declined |
| AT-I3-005 | Roles can be assigned | 1. Open group settings 2. Assign role 3. Save | Role assignment recorded |

#### Authorization Verification

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-I3-006 | Member cannot perform organizer actions | 1. Login as member 2. Attempt to edit group settings | Error: insufficient permissions |
| AT-I3-007 | Treasurer cannot manage group members | 1. Login as treasurer 2. Attempt to remove member | Error: insufficient permissions |
| AT-I3-008 | Viewer cannot modify data | 1. Login as viewer 2. Attempt any modification | Error: read-only |

### Category 4: Non-Functional Acceptance

| ID | Requirement | Test Steps | Expected Result |
|----|------------|-----------|-----------------|
| AT-NF-001 | Dashboard loads within 2 seconds | 1. Login 2. Time dashboard load | Loads within 2 seconds |
| AT-NF-002 | API responses within 500ms | 1. Measure API response time | Within 500ms for standard operations |
| AT-NF-003 | Financial operations are atomic | 1. Force failure mid-transaction 2. Check database | No partial data persisted |
| AT-NF-004 | All API endpoints require auth (except public) | 1. Call endpoint without token | 401 returned |
| AT-NF-005 | HTTPS enforced in production | 1. Attempt HTTP connection | Redirect to HTTPS |
| AT-NF-006 | Error messages don't leak internals | 1. Trigger server error | Generic error message returned |

## Running Acceptance Tests

### Manual Acceptance Tests

1. Log in with test credentials
2. Navigate to relevant feature
3. Follow test steps
4. Verify expected result
5. Record pass/fail with notes

### Automated Acceptance Tests

- E2E tests in `tests/CircleFund.E2ETests/` cover key workflows
- API integration tests verify server-side acceptance criteria
- Results stored in `docs/06-verification/test-results/`
