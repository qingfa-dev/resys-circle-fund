# 08-operations — README

## Purpose

How CircleFund is run in production: the daily runbook, monitoring/metrics/alerts, incident response, and backup & recovery/disaster recovery.

## Key Terms

- **Runbook** — daily checklist, health checks, sync health, DB ops, restarts.
- **Monitoring** — metrics, thresholds, structured logging, sync/financial dashboards.
- **Incident response** — severities (P0–P3), process, offline/sync incidents.
- **Backup & recovery** — backup types, restore procedures, DR; RPO/RTO.

## Contents

```
08-operations/
├── README.md
├── operations-runbook.md   index → operations-runbook/ (3)
├── monitoring.md           index → monitoring/ (3)
├── incident-response.md    index → incident-response/ (3)
└── backup-recovery.md      index → backup-recovery/ (3)
```

## Usage

- **Daily ops:** `operations-runbook/`.
- **Set up alerts:** `monitoring/01-metrics-and-alerts.md`.
- **During an incident:** `incident-response/`.
- **Restore data:** `backup-recovery/`.

## Cross-references

- Deploy/rollback: `../07-release/`
- Security controls: `../04-design/security-design/`
- Data schema: `../03-architecture/data-model/`