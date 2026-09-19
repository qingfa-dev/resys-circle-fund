# Operations Runbook — Daily & Health

**Index:** `docs/08-operations/operations-runbook.md`

## Daily Checklist
- [ ] System health dashboard
- [ ] Overnight error logs
- [ ] Backup completion (I3+)
- [ ] Alerts from monitoring
- [ ] Failed background jobs
- [ ] Sync-health dashboard (pending/conflict counts)
- [ ] Notification delivery status

## Health Checks

```bash
curl https://api.circlefund.example.com/health
docker compose exec db pg_isready -U circlefund -d circlefund
df -h
docker compose exec db psql -U circlefund -d circlefund -c "SELECT pg_size_pretty(pg_database_size('circlefund'));"
```

Expected API health: `{ "status": "Healthy", "version": "...", "uptime": "..." }`.