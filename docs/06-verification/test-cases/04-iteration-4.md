# Test Cases — Iteration 4 (Group Collaboration)

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I4-001..003 | Create group / invite / accept / reject / remove | membership flows |
| TC-I4-004..005 | Roles & permissions enforced + audited | 403 on forbidden; audit |
| TC-I4-006..007 | Announcements publish / archive / view | persisted |
| TC-I4-008..009 | Voting: cast once; quorum | enforced |
| TC-I4-010..011 | Rules versioning | history preserved, audited |
| TC-I4-012..013 | Fines / appeals | lifecycle enforced |
| TC-I4-014..015 | Messages + membership permission | sender/timestamp retained |
| TC-I4-016..017 | Meetings / attendance / minutes | recorded |
| TC-I4-018..019 | Tasks create/assign/complete | lifecycle |
| TC-I4-020 | Collaboration never mutates financial state | no ledger/balance change |