# Operations Runbook — Logs, Database & Restart

## Logs

```bash
docker compose logs -f api
docker compose exec db cat /var/log/postgresql/postgresql-15-main.log
# slow queries
docker compose exec db psql -U circlefund -d circlefund -c "SELECT * FROM pg_stat_statements ORDER BY mean_time DESC LIMIT 10;"
```

## Database Operations

```bash
docker compose exec db psql -U circlefund -d circlefund -c "SELECT count(*) FROM pg_stat_activity;"
docker compose exec db vacuumdb -U circlefund -d circlefund --analyze
docker compose exec db reindexdb -U circlefund -d circlefund
docker compose exec api dotnet ef database update
```

## Restart Procedures

```bash
docker compose restart api                              # rolling
docker compose down && docker compose up -d             # full
docker compose kill api && docker compose rm -f api && docker compose up -d api  # emergency
```

Monitoring integration: see `docs/08-operations/monitoring/`.