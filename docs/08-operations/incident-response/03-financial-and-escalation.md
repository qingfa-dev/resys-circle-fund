# Incident Response — Financial Procedure & Escalation

## Financial Incident Procedure

```text
STOP → ASSESS (scope) → NOTIFY → PRESERVE (logs/DB) → INVESTIGATE
→ CORRECT (compensating transactions) → VERIFY (manual calc)
→ COMMUNICATE → DOCUMENT → PREVENT
```

## Escalation Matrix

| Time | P0 | P1 | P2 | P3 |
| --- | --- | --- | --- | --- |
| 0–5 min | All hands | All hands | Investigate | Monitor |
| 5–15 min | Management | Tech Lead | Begin investigation | Monitor |
| 15–30 min | Infrastructure | Full team | Escalate if unresolved | Log |
| 30–60 min | Executive notify | Management | Escalate senior | Begin |
| 1h+ | External comms | External if needed | Full team | In progress |

## Post-Incident Review
RCA document (timeline, root cause, contributing factors, corrective actions with owner+due, lessons); update runbooks and monitoring if gaps found.