# Operations Runbook — Sync Health

Track unresolved sync state:

```sql
SELECT status, count(*) FROM local_operations
WHERE status IN ('pending','conflict','failed')
GROUP BY status;
```

- A rising `conflict` count signals sync conflicts needing user resolution (FR-I1-044).
- A rising `failed` count signals replay errors needing investigation.
- Pending-sync records must stay visually distinct (FR-I2-049).

## Backup (I3+)
Scheduled backups to Backup Storage (FR-I3-027); manual backup/verification; details in `docs/08-operations/backup-recovery/`.