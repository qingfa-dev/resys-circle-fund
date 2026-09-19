# Backup & Recovery — Procedures & Testing

## Full Database Restore

```text
1. Stop application → 2. Drop & recreate database → 3. Restore from backup
→ 4. Apply WAL for point-in-time recovery → 5. Start → 6. Verify integrity
```

```bash
docker compose down api
docker compose exec db psql -U postgres -c "DROP DATABASE IF EXISTS circlefund;"
docker compose exec db psql -U postgres -c "CREATE DATABASE circlefund OWNER circlefund;"
gunzip < /opt/circlefund/backups/circlefund_<ts>.dump.gz \
  | docker compose exec -i db pg_restore -U circlefund -d circlefund
docker compose up -d api
curl https://api.circlefund.example.com/health
```

## Configuration Recovery
Restore `docker-compose.yml`, `nginx.conf`, env vars from git + secrets manager; restart; verify.

## Audit Trail Recovery
Restore audit records; verify sequence integrity, timestamp gaps, correlation IDs, actor completeness.

## Sync-State Recovery
After restore, clients re-sync to rebuild local state; server idempotency keys prevent replays of already-committed operations.

## Recovery Testing
Monthly drill: restore to a test environment, compare against a pre-drill snapshot, document results.