# Backup & Recovery — Types & Integration

**Index:** `docs/08-operations/backup-recovery.md`

## Backup Types

| Type | Frequency | Retention | Purpose |
| --- | --- | --- | --- |
| Full DB dump | Daily | 90 days | Complete recovery |
| WAL archiving | Continuous | 7 days | Point-in-time recovery |
| Configuration | On change (git) | 1 year | Infra recovery |
| Audit trail | Daily | 90 days | Compliance |

## Backup Integration (FR-I3-027 to 031)
Scheduled backups via Backup Storage; manual backups; metadata retained; restore audited. A failed backup is detected and alerted. A backup is reliable only after restore has been tested (NFR-020).

```bash
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
docker compose exec db pg_dump -U circlefund -Fc circlefund \
  | gzip > "/opt/circlefund/backups/circlefund_${TIMESTAMP}.dump.gz"
```