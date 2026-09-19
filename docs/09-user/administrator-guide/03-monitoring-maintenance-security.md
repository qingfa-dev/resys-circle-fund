# Administrator Guide — Monitoring, Maintenance, Security

**Index:** `docs/09-user/administrator-guide.md`

## Monitoring & Logs
See `docs/08-operations/monitoring/`. Key errors: DB failures, auth failures (brute force), financial operation failures, slow queries.

## Maintenance
- Scheduled: notify → maintenance mode → tasks → verify → resume.
- Database (daily/weekly/monthly): backups, vacuum, reindex, slow-query review, restore drills.
- Updates: review notes → test staging → backup → deploy → migrate → verify.

## Backup Management
Schedule backups via Backup Storage (I3), on-demand backups, verify integrity, test restore monthly (NFR-020).

## Security Administration
Review access; deactivate inactive accounts; enforce password policy; monitor failed logins; review roles quarterly. Checklist: valid TLS, auth on all endpoints except public, no known vulnerabilities, encrypted DB/backups, rate limiting, audit logging.