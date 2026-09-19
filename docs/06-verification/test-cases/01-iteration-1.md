# Test Cases — Iteration 1 (Offline-First Core)

## Identity

| ID | Scenario | Steps | Expected |
| --- | --- | --- | --- |
| TC-I1-001 | Register valid | POST /auth/register {valid} | 201; account Pending; unique id |
| TC-I1-002 | Register duplicate email | register twice | 400/409 duplicate |
| TC-I1-003 | Register weak password | password "abc" | 400 policy |
| TC-I1-004 | Login valid | POST /auth/login {valid} | 200; access+refresh token |
| TC-I1-005 | Login invalid | wrong password | 401; no info leak |
| TC-I1-006 | Refresh token | POST /auth/refresh | new access token |
| TC-I1-007 | Update profile | PUT /users/me/profile | 200; persisted |
| TC-I1-008 | Logout | POST /auth/logout | session invalidated |

## Savings Circle & Round

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I1-009..011 | Create circle valid / missing field / duplicate name | 201 / 400 / 409 |
| TC-I1-012 | Edit circle config | 200; audited |
| TC-I1-013 | Pause / activate | status Active↔Paused |
| TC-I1-014 | Close (open rounds) | 422 forbidden |
| TC-I1-015 | Close (no open rounds) | status Closed |
| TC-I1-016 | Generate rounds per schedule | N rounds created, sequential numbers |
| TC-I1-017 | Open → Complete → Close round | status transitions enforced |

## Member & Share

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I1-018..019 | Add member / duplicate | 201 / 409 |
| TC-I1-020..021 | Assign single / multiple shares | persisted; multiple only when allowed |
| TC-I1-022 | Transfer share | ownership changed; history kept |
| TC-I1-023 | Suspend / remove member | status changes; suspended can't contribute |

## Contribution & Balance

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I1-024 | Record contribution valid | 200; ledger entry + audit + balance |
| TC-I1-025..026 | Zero / negative amount | 400 (CHECK + validator) |
| TC-I1-027 | Duplicate (same key) | cached result, no duplicate |
| TC-I1-028 | Duplicate (same member/share/round, new key) | 409 unique |
| TC-I1-029 | Closed round / inactive member | 422 |
| TC-I1-030 | Correction (reverse + correct) | original preserved; two entries |
| TC-I1-031 | Balance derived from ledger | equals Σ entries |
| TC-I1-032..034 | Member / round / circle balance | correct totals |

## Dashboard & Notifications

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I1-035..038 | Dashboard content; reminders generated; status tracked | correct aggregates |

## Offline Capture & Sync

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I1-039 | Contribution offline | queued pending with localId |
| TC-I1-040 | Two devices edit same share offline | conflict surfaced, both versions |
| TC-I1-041 | Reconnect → replay | exactly-once (idempotency) |
| TC-I1-042 | LocalId collides with server id | detected + remapped |
| TC-I1-043 | Per-record sync status shown | pending/synced/conflict |

## Authorization

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I1-044 | Unauthenticated mutation | 401 |
| TC-I1-045 | Member edits circle | 403 |
| TC-I1-046 | Organizer edits circle | 200 |
| TC-I1-047 | Treasurer records contribution | 200 |
| TC-I1-048 | Viewer records contribution | 403 |