# Operations Runbook — CircleFund

## Overview

This runbook covers day-to-day operations for the CircleFund application.

## System Architecture Overview

```text
┌─────────────────────────────┐
│         Frontend (PWA)       │
│     Vue 3 + TypeScript       │
└──────────┬──────────────────┘
           │ HTTPS (REST API)
           ▼
┌─────────────────────────────┐
│         API Server           │
│    ASP.NET Core 8           │
│    (Docker container)        │
├─────────────────────────────┤
│    EF Core → PostgreSQL      │
│    (Docker container)        │
└─────────────────────────────┘
```

## Daily Operations Checklist

### Morning

- [ ] Check system health dashboard
- [ ] Review overnight error logs
- [ ] Check backup completion (if automated)
- [ ] Review any alerts from overnight monitoring
- [ ] Check for failed background jobs
- [ ] Verify email/notification service status

### During Day

- [ ] Monitor error rates
- [ ] Monitor response times
- [ ] Review user reports
- [ ] Check disk space usage
- [ ] Review database connection pool usage

### End of Day

- [ ] Review daily metrics
- [ ] Check for failed backups
- [ ] Review security logs
- [ ] Plan maintenance for next day (if any)

## Health Checks

### API Health Endpoint

```bash
curl https://api.circlefund.example.com/health
```

Expected response:

```json
{
    "status": "Healthy",
    "version": "1.0.0",
    "uptime": "1.00:00:00"
}
```

### Database Health

```bash
docker compose exec db pg_isready -U circlefund -d circlefund
```

Expected: `Database is accepting connections`

### Disk Space

```bash
# Check server disk
df -h

# Check database size
docker compose exec db psql -U circlefund -d circlefund \
  -c "SELECT pg_size_pretty(pg_database_size('circlefund'));"

# Check Docker disk usage
docker system df
```

## Backup Operations

### Automated Backups

Backups should be configured to run daily (adjust schedule as needed):

```bash
#!/bin/bash
# backup.sh — Daily backup script
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups"
mkdir -p "$BACKUP_DIR"

# PostgreSQL backup
docker compose exec db pg_dump -U circlefund circlefund \
  | gzip > "$BACKUP_DIR/circlefund_$TIMESTAMP.sql.gz"

# Prune backups older than 90 days
find "$BACKUP_DIR" -name "circlefund_*.sql.gz" -mtime +90 -delete
```

### Manual Backup

```bash
# Create on-demand backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
docker compose exec db pg_dump -U circlefund circlefund \
  | gzip > /backups/circlefund_manual_$TIMESTAMP.sql.gz

# Verify backup
ls -lh /backups/circlefund_manual_$TIMESTAMP.sql.gz
```

### Backup Verification

Periodically verify backup integrity:

```bash
# Check backup file integrity
zcat /backups/circlefund_latest.sql.gz | head -100

# Test restore on a separate database (monthly)
# Create test database from backup and verify tables exist
```

## Log Management

### Application Logs

```bash
# View live logs
docker compose logs -f api

# View logs for last hour
docker compose logs --since 1h api

# Search for errors
docker compose logs api | grep -i "error" | tail -50

# Logs location (if persisted)
ls -lh /var/log/circlefund/api/
```

### Database Logs

```bash
# PostgreSQL logs
docker compose exec db cat /var/log/postgresql/postgresql-15-main.log

# Slow queries (if configured)
docker compose exec db psql -U circlefund -d circlefund \
  -c "SELECT * FROM pg_stat_statements ORDER BY mean_time DESC LIMIT 10;"
```

### Log Rotation

Configure log rotation:

```bash
# /etc/logrotate.d/circlefund
/var/log/circlefund/api/*.log {
    daily
    rotate 14
    compress
    missingok
    notifempty
    copytruncate
}
```

## Database Operations

### View Database Status

```bash
# Connection count
docker compose exec db psql -U circlefund -d circlefund \
  -c "SELECT count(*) FROM pg_stat_activity;"

# Active connections
docker compose exec db psql -U circlefund -d circlefund \
  -c "SELECT * FROM pg_stat_activity WHERE state = 'active';"

# Table sizes
docker compose exec db psql -U circlefund -d circlefund \
  -c "
  SELECT tablename, pg_size_pretty(pg_total_relation_size(tablename)) 
  FROM pg_tables WHERE schemaname = 'public'
  ORDER BY pg_total_relation_size(tablename) DESC;
  "
```

### Run Database Migration

```bash
# Apply migrations
docker compose exec api dotnet ef database update

# Check migration status
docker compose exec api dotnet ef migrations list
```

### Database Maintenance

```bash
# Vacuum (PostgreSQL)
docker compose exec db vacuumdb -U circlefund -d circlefund --analyze

# Reindex
docker compose exec db reindexdb -U circlefund -d circlefund
```

## Restart Procedures

### Rolling Restart (No Downtime)

```bash
# Restart API container (database connection re-established)
docker compose restart api
```

### Full Restart

```bash
docker compose down
docker compose up -d
```

### Emergency Restart

```bash
# Kill and restart if container is unresponsive
docker compose kill api
docker compose rm -f api
docker compose up -d api
```

## Monitoring Setup

### Application Metrics

Track the following metrics:

| Metric | Source | Alert Threshold |
|--------|--------|----------------|
| Error rate | Application logs | >1% of requests |
| Response time | Application logging | >500ms average |
| CPU usage | Docker metrics | >80% sustained |
| Memory usage | Docker metrics | >80% of allocated |
| Disk usage | System monitoring | >85% |
| Database connections | pg_stat_activity | >80% max connections |
| Failed login attempts | Application logs | >10 in 5 minutes |
| Background job failures | Job logs | >3 consecutive |

### Health Check Configuration

Configure monitoring to check:

- API health endpoint every 30 seconds
- Database connection every 60 seconds
- Server disk space every 5 minutes
- SSL certificate expiry (30 days before expiry)
