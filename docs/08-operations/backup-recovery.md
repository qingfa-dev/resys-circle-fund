# Backup & Recovery — CircleFund

## Overview

This document defines backup and recovery procedures for CircleFund's data and configuration.

## Backup Strategy

### Backup Types

| Type | Frequency | Retention | Purpose |
|------|-----------|-----------|---------|
| Full database dump | Daily | 90 days | Complete recovery |
| Transaction log WAL | Continuous (WAL archiving) | 7 days | Point-in-time recovery |
| Configuration backup | On change | 1 year | Infrastructure recovery |
| Application logs | Daily rotation | 30 days | Troubleshooting |
| Audit trail backup | Daily | 90 days | Compliance |

### Backup Schedule

```text
02:00 — Full PostgreSQL dump (daily)
Continuous — WAL archiving enabled
On change — Configuration backup (git)
Daily — Log rotation and archival
Weekly — Backup verification test (manual)
Monthly — Full recovery test (manual)
```

## Database Backup

### Automated PostgreSQL Backup

```bash
#!/bin/bash
# /opt/circlefund/scripts/backup-db.sh
set -euo pipefail

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/opt/circlefund/backups/db"
mkdir -p "$BACKUP_DIR"

# Full dump
docker compose exec db pg_dump -U circlefund -Fc circlefund \
  > "$BACKUP_DIR/circlefund_full_$TIMESTAMP.dump"

# Compress
gzip "$BACKUP_DIR/circlefund_full_$TIMESTAMP.dump"

# Keep only last 90 days
find "$BACKUP_DIR" -name "circlefund_full_*.dump.gz" -mtime +90 -delete

echo "Backup complete: circlefund_full_$TIMESTAMP.dump.gz"
```

### Backup Verification

```bash
# Check backup integrity
pg_restore --list /opt/circlefund/backups/db/circlefund_full_20240115_020000.dump.gz
```

## Recovery Procedures

### Scenario 1: Full Database Restore

```text
1. Identify point of recovery (date/time)
2. Stop application
3. Restore database from backup
4. Apply WAL logs for point-in-time recovery (if needed)
5. Start application
6. Verify data integrity
```

Steps:

```bash
# 1. Stop application
docker compose down api

# 2. Drop existing database and recreate
docker compose exec db psql -U postgres -c "DROP DATABASE IF EXISTS circlefund;"
docker compose exec db psql -U postgres -c "CREATE DATABASE circlefund OWNER circlefund;"

# 3. Restore from backup
gunzip < /opt/circlefund/backups/db/circlefund_full_20240115_020000.dump.gz \
  | docker compose exec -i db pg_restore -U circlefund -d circlefund

# 4. Apply WAL logs for point-in-time recovery (if needed)
# (Configure recovery_target_time in postgresql.conf if needed)

# 5. Start application
docker compose up -d api

# 6. Verify
curl https://api.circlefund.example.com/health
# Check circle count, user count, recent transactions
```

### Scenario 2: Partial Recovery (Specific Table)

```bash
# Restore full backup to temp database
# Extract specific table from temp
# Insert into production database
```

### Scenario 3: Configuration Recovery

```text
1. Identify lost/missing configuration
2. Retrieve from Git repository (version controlled)
3. Recreate environment variables from secrets manager
4. Restart services
5. Verify
```

Steps:

```bash
# Restore from git history
git checkout HEAD -- docker-compose.yml nginx.conf

# Environment variables — check secrets manager or backup
# Re-enter environment variables in deployment configuration
docker compose up -d
```

### Scenario 4: Audit Trail Recovery

Audit trail data is critical for financial compliance:

```text
1. Restore audit records from database backup
2. Verify sequence integrity
3. Verify no gaps in timestamps
4. Verify correlation IDs present
5. Verify actor information complete
```

## Backup Storage

### Local Storage (Primary)

- Backups stored on server at `/opt/circlefund/backups/`
- Minimum 3x daily backup size for local storage
- Compressed to reduce storage requirements

### Off-Site Storage (Recommended)

- Backups replicated to cloud storage (S3, Blob, GCS)
- Encrypted at rest in off-site storage
- Replicated across availability zones

### Backup Encryption

All backups are encrypted:

```bash
# Encrypt backup
gpg --symmetric --cipher-algo AES256 \
  /opt/circlefund/backups/db/circlefund_full_$TIMESTAMP.dump

# Decrypt for restore
gpg --decrypt circlefund_full_$TIMESTAMP.dump.gpg \
  | pg_restore -U circlefund -d circlefund
```

## Recovery Testing

### Monthly Recovery Drill

1. Schedule recovery test during low-traffic period
2. Document current system state (snapshot)
3. Restore database to test environment from backup
4. Verify data integrity
5. Compare with snapshot
6. Document results
7. Restore production from snapshot

### Recovery Checklist

- [ ] Backup file exists for target date
- [ ] Backup file integrity verified
- [ ] Sufficient storage for restored database
- [ ] Database server available
- [ ] Application stopped before restore
- [ ] Database recreated before restore
- [ ] Restore completed without errors
- [ ] Application started after restore
- [ ] Health check passes
- [ ] Core workflows verified
- [ ] Financial data verified against audit trail

## RPO and RTO Targets

| Metric | Target | Notes |
|--------|--------|-------|
| RPO (Recovery Point Objective) | 24 hours | Maximum data loss accepted |
| RTO (Recovery Time Objective) | 2 hours | Maximum time to restore service |
| RPO (financial data) | 0 hours | No data loss for financial data (WAL + real-time) |

## Disaster Recovery

For complete server failure:

1. Provision new server
2. Install Docker and Docker Compose
3. Restore database from latest backup
4. Restore configuration from Git
5. Restore secrets from secrets manager
6. Configure SSL certificates (re-issue if needed)
7. Deploy application
8. Verify full functionality
9. Update DNS if IP changed
10. Document incident and lessons learned
