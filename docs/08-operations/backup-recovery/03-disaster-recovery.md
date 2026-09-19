# Backup & Recovery — Disaster Recovery

## DR Process

```text
Detect outage/failure
  → Provision replacement server
  → Install Docker + Compose
  → Restore database from latest verified backup
  → Restore configuration (git) + secrets (secret manager)
  → Re-issue TLS certificates
  → Deploy application
  → Verify (health, login, circle/contribution, financial spot-check)
  → Update DNS if IP changed
  → Document incident + run post-mortem
```

## RPO / RTO Targets (NFR-021)

| Metric | Baseline |
| --- | --- |
| RPO | ≤ 24 hours (financial data targets ~0 via WAL) |
| RTO | ≤ 4 hours |

## DR Runbook Essentials

- Verified backup path + latest known-good restore timestamp.
- Secrets recovery procedure (where are keys stored).
- DNS + TLS re-issuance steps.
- Post-restore verification checklist (health, auth, create circle, record contribution, balances vs audit).