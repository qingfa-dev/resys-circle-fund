# Test Cases — Iteration 5 (Advanced Platform)

| ID | Scenario | Expected |
| --- | --- | --- |
| TC-I5-001..002 | Account create/balance; transfer creates ledger record | correct |
| TC-I5-003 | Transfer idempotent | no duplicate on retry |
| TC-I5-004..005 | Budget utilization/variance | correct math |
| TC-I5-006..007 | Invoice status/line items/history | preserved |
| TC-I5-008..009 | Document versions + permissions | enforced |
| TC-I5-010..011 | Calendar (rounds/reminders/meetings/tasks/votes) | unified |
| TC-I5-012..014 | Import validate→parse→preview→confirm→transactional | never bypasses validation; row errors |
| TC-I5-015..016 | Export complete + relationship-preserving + auth | correct + authorized |
| TC-I5-017 | Community moderation | moderator actions enforced |