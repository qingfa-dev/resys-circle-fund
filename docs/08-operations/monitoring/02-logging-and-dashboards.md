# Monitoring — Logging & Dashboards

## Logging
Structured JSON: timestamp, level, service, environment, user ID, request/correlation ID, operation, result, error code, duration (NFR-023). No secrets. Correlation IDs link a logical operation across logs, ledger, and audit.

## Sync-Health Dashboard
Per circle: queued/pending, syncing, synced, conflict, failed; replication latency; last successful sync. Pending records visibly distinguished (FR-I2-049).

## Backup & Restore Monitoring
Track scheduled-backup success, verification status, and restore drills (NFR-020). A failed backup is alerted, never silently skipped (FR-I3-031).