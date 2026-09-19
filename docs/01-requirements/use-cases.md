# Use Cases — CircleFund

## Iteration 1 — Core Circle Management

### Identity & Account

| ID | Use Case | Primary Actor | Preconditions | Main Flow | Postconditions |
|----|----------|--------------|---------------|-----------|----------------|
| UC-I1-001 | Register Account | Visitor | None | 1. Visitor provides registration info 2. System validates 3. Account created 4. Verification sent | Account exists in Pending state |
| UC-I1-002 | Verify Account | Registered User | Account exists in Pending | 1. User clicks verification link 2. System verifies email/phone 3. Account activated | Account in Active state |
| UC-I1-003 | Login | Registered User | Account in Active | 1. User provides credentials 2. System validates 3. Session/Token issued | User authenticated |
| UC-I1-004 | Logout | Registered User | User authenticated | 1. User requests logout 2. Session invalidated | User no longer authenticated |
| UC-I1-005 | Recover Account | Registered User | Account exists | 1. User requests recovery 2. Recovery link sent 3. User resets password 4. Credentials updated | Password changed |
| UC-I1-006 | Manage Profile | Registered User | User authenticated | 1. User views profile 2. User updates info 3. System validates 4. Profile saved | Profile updated |
| UC-I1-007 | Lock/Unlock Application | Registered User | User authenticated | 1. User locks/unlocks via PIN/biometric | Application locked/unlocked |

### Savings Circle

| ID | Use Case | Primary Actor | Preconditions | Main Flow | Postconditions |
|----|----------|--------------|---------------|-----------|----------------|
| UC-I1-008 | Create Circle | Chủ Hụi | User authenticated, authorized | 1. Organizer provides circle config 2. System validates 3. Circle created 4. Organizer assigned | Circle exists in Active state |
| UC-I1-009 | Configure Circle Type | Chủ Hụi | Circle exists, organizer | 1. Organizer selects type 2. Type-specific config collected 3. System validates 4. Type set | Circle type configured |
| UC-I1-010 | View Circle | Chủ Hụi / Hụi Viên | Circle accessible | 1. User requests circle view 2. System retrieves data 3. Circle info displayed | None |
| UC-I1-011 | Edit Circle | Chủ Hụi | Circle exists, organizer | 1. Organizer modifies config 2. System validates 3. Changes saved | Circle updated |
| UC-I1-012 | Pause Circle | Chủ Hụi | Circle in Active state | 1. Organizer pauses 2. System updates status | Circle in Paused state |
| UC-I1-013 | Close Circle | Chủ Hụi | Circle in Paused/Active, no open periods | 1. Organizer closes 2. Final reconciliation 3. Circle closed | Circle in Closed state |
| UC-I1-014 | View Historical Circle | Authorized User | Access permission | 1. System retrieves archived data 2. History displayed | None |

### Periods (Kỳ Hụi)

| ID | Use Case | Primary Actor | Preconditions | Main Flow | Postconditions |
|----|----------|--------------|---------------|-----------|----------------|
| UC-I1-015 | Generate Periods | Chủ Hụi | Circle exists, organizer | 1. Organizer triggers generation 2. System creates periods per schedule 3. Periods numbered | Periods exist |
| UC-I1-016 | View Period Schedule | Chủ Hụi / Hụi Viên | Circle accessible | 1. System retrieves periods 2. Schedule displayed | None |
| UC-I1-017 | Open Period | Chủ Hụi | Period in Scheduled state | 1. Organizer opens period 2. Status changed | Period in Open state |
| UC-I1-018 | Complete Period | Chủ Hụi | All contributions due recorded | 1. Organizer completes period 2. System validates 3. Period finalized | Period in Completed state |
| UC-I1-019 | Close Period | Chủ Hụi | Period in Completed state | 1. Organizer closes period 2. Final records saved | Period in Closed state |
| UC-I1-020 | Adjust Period Date | Chủ Hụi | Period in Scheduled state | 1. Organizer changes date 2. System validates 3. Date updated | Period date updated |

### Members & Shares

| ID | Use Case | Primary Actor | Preconditions | Main Flow | Postconditions |
|----|----------|--------------|---------------|-----------|----------------|
| UC-I1-021 | Add Member | Chủ Hụi | Circle exists, organizer | 1. Organizer provides member info 2. System validates 3. Member added | Member in Active state |
| UC-I1-022 | View Member | Chủ Hụi / Hụi Viên | Circle accessible | 1. System retrieves member info 2. Info displayed | None |
| UC-I1-023 | Suspend Member | Chủ Hụi | Member is Active | 1. Organizer suspends 2. System validates 3. Status changed | Member in Suspended state |
| UC-I1-024 | Remove Member | Chủ Hụi | Member exists | 1. Organizer removes 2. System checks implications 3. Member removed | Membership ended |
| UC-I1-025 | Assign Share | Chủ Hụi | Circle exists | 1. Organizer assigns share(s) 2. System validates 3. Share recorded | Share assignment exists |
| UC-I1-026 | Assign Multiple Shares | Chủ Hụi | Circle permits multiple shares | 1. Organizer assigns multiple 2. System validates constraints 3. Shares recorded | Multiple shares exist |
| UC-I1-027 | Transfer Share | Chủ Hụi | Shares available | 1. Organizer transfers share 2. System validates 3. Share transferred | Ownership changed |
| UC-I1-028 | View Membership History | Authorized User | Access permission | 1. System retrieves history 2. History displayed | None |

### Contributions & Balance

| ID | Use Case | Primary Actor | Preconditions | Main Flow | Postconditions |
|----|----------|--------------|---------------|-----------|----------------|
| UC-I1-029 | Record Contribution | Chủ Hụi / Treasurer | Period open, member active | 1. Actor records contribution 2. System validates (amount, member, period, duplicate) 3. Transaction committed 4. Balance updated 5. Ledger entry created | Contribution recorded |
| UC-I1-030 | View Payment Status | Chủ Hụi / Hụi Viên | Circle accessible | 1. System retrieves payment status 2. Status displayed | None |
| UC-I1-031 | View Contribution History | Authorized User | Access permission | 1. System retrieves history 2. History displayed | None |
| UC-I1-032 | Correct Contribution | Authorized User | Contribution exists, correction authorized | 1. Initiate correction 2. Reversal entry created 3. Correction entry created 4. Balances recalculated | Correction recorded |
| UC-I1-033 | View Member Balance | Chủ Hụi / Hụi Viên | Circle accessible | 1. System calculates balance from ledger 2. Balance displayed | None |
| UC-I1-034 | View Period Balance | Chủ Hụi | Circle accessible | 1. System calculates period collection 2. Status displayed | None |
| UC-I1-035 | View Circle Balance | Chủ Hụi | Circle accessible | 1. System calculates aggregate balance 2. Summary displayed | None |
| UC-I1-036 | Recalculate Balance | System | Ledger entries exist | 1. System derives balance from ledger 2. Values updated in read model | Balance data refreshed |

### Dashboard & Notifications

| ID | Use Case | Primary Actor | Preconditions | Main Flow | Postconditions |
|----|----------|--------------|---------------|-----------|----------------|
| UC-I1-037 | Dashboard | Registered User | Authenticated | 1. System aggregates data 2. Dashboard rendered | None |
| UC-I1-038 | Send Reminders | System / Scheduler | Period open, contributions unpaid | 1. Scheduler triggers 2. System identifies unpaid 3. Reminders sent | Notifications dispatched |
| UC-I1-039 | Track Reminder Status | Authorized User | Reminders sent | 1. System retrieves status 2. Status displayed | None |
