# Test Cases — Iteration 3 (Integrations)

| ID | Scenario | Steps | Expected |
| --- | --- | --- | --- |
| TC-I3-001 | Notification delivery | trigger event → deliver | status Sent/Delivered |
| TC-I3-002 | Notification preference | set channel | honored |
| TC-I3-003 | Failed notification does not roll back | force notify failure | business op still committed |
| TC-I3-004 | Retry policy | transient failure | retried, bounded |
| TC-I3-005..006 | File upload valid / invalid type/size | upload | stored / rejected |
| TC-I3-007..008 | File scan + authorize | upload + fetch | blocked / authorized |
| TC-I3-009..010 | External login / link / revoke | login via IdP | linked; revocable |
| TC-I3-011..012 | AI interpret → confirm; AI never commits | submit NL | proposal shown; commit only on confirm |
| TC-I3-013..014 | Analytics read-only; subscription entitlement/expiry | query | never mutates; enforced |
| TC-I3-015 | Backup schedule / manual / restore / audit | backup + restore | metadata; restore audited |