# Incident Response — Severity & Process

**Index:** `docs/08-operations/incident-response.md`

## Severity

| Severity | Description | Response |
| --- | --- | --- |
| P0 | System down, financial data incorrect, data loss | Immediate (5 min) |
| P1 | Major feature broken, financial inconsistency | 15 min |
| P2 | Minor feature, performance | 1h |
| P3 | Cosmetic | Next business day |

## Process

```text
Detection → Classification → Containment → Diagnosis → Recovery → Verification → RCA → Corrective action → Communication → Documentation
```

Containment: stop financial ops, maintenance mode, feature flag off, block suspicious requests.