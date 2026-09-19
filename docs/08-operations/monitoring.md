# Monitoring — CircleFund

## Overview

Monitoring ensures CircleFund is healthy, performant, and secure. The monitoring strategy is progressive, starting with essential monitoring and expanding as the system grows.

## Monitoring Stack (Progressive)

### Phase 1 — Essential Monitoring

- Docker container health checks
- API health endpoint (`/health`)
- Database connection status
- Error rate from application logs
- Response time from access logs
- Disk space monitoring
- SSL certificate expiry
- Uptime monitoring (external service)

### Phase 2 — Application Performance Monitoring

- Structured logging with correlation IDs
- Request/response metrics (timers, counters)
- Database query performance (slow queries)
- Background job metrics (duration, failures)
- Caching hit rates
- Queue depth (outbox processing)

### Phase 3 — Full Observability (Future)

- Distributed tracing
- Custom business metrics (contributions per day, payout amounts)
- Real-time dashboards
- Alert correlation
- AI anomaly detection (future)

## Metrics to Monitor

### System Metrics

| Metric | Source | Alert Threshold | Evaluation Window |
|--------|--------|----------------|-------------------|
| CPU Usage | Docker | >80% | 5 minutes |
| Memory Usage | Docker | >80% of allocated | 5 minutes |
| Disk Usage | System | >85% | 5 minutes |
| Disk I/O | System | Sustained high | 10 minutes |
| Network In/Out | Docker | Unusual spikes | 5 minutes |

### Application Metrics

| Metric | Source | Alert Threshold | Evaluation Window |
|--------|--------|----------------|-------------------|
| HTTP 5xx Rate | Application logs | >1% of requests | 5 minutes |
| HTTP 4xx Rate | Application logs | >10% of requests | 5 minutes |
| Average Response Time | Application logs | >1 second | 5 minutes |
| P95 Response Time | Application logs | >3 seconds | 5 minutes |
| Database Connection Pool | pg_stat_activity | >80% max | 5 minutes |
| Health Check Failures | External monitor | >2 consecutive | 2 minutes |

### Business Metrics

| Metric | Source | Alert Threshold | Evaluation Window |
|--------|--------|----------------|-------------------|
| Failed Contributions | Application logs | >5% of attempts | 1 hour |
| Failed Payouts | Application logs | >2 in 1 hour | 1 hour |
| Duplicate Operations Detected | Application logs | Unusual spike | 1 hour |
| Background Job Failures | Job logs | >3 consecutive | 30 minutes |
| Reconciliation Discrepancies | Application logs | Any unresolved | 24 hours |

### Security Metrics

| Metric | Source | Alert Threshold | Evaluation Window |
|--------|--------|----------------|-------------------|
| Failed Logins | Application logs | >10 from same IP | 5 minutes |
| Failed Auth Attempts | Application logs | >50 from same IP | 5 minutes |
| Authorization Denials | Application logs | >20 in 1 hour | 1 hour |
| Unusual Access Patterns | Application logs | Anomaly detected | Real-time |

## Logging

### Log Structure

```json
{
    "timestamp": "2026-09-15T10:30:00Z",
    "level": "Information",
    "message": "Contribution recorded successfully",
    "correlationId": "550e8400-e29b-41d4-a716-446655440000",
    "userId": "user-uuid",
    "circleId": "circle-uuid",
    "operation": "ContributionRecorded",
    "amount": 1000000.00,
    "duration": 45,
    "exception": null
}
```

### Log Levels

| Level | Usage |
|-------|-------|
| **Error** | Operational failures requiring investigation |
| **Warning** | Potential issues, non-critical failures |
| **Information** | Business operations, key events |
| **Debug** | Detailed diagnostic information |
| **Trace** | Very detailed (only when troubleshooting) |

### Log Retention

| Log Type | Retention | Storage |
|----------|-----------|---------|
| Error logs | 90 days | Hot storage |
| Information logs | 30 days | Hot storage |
| Debug logs | 7 days | Hot storage |
| Audit logs | 90 days (financial), 7 years (regulated) | Cold storage (progressive) |
| Access logs | 90 days | Hot storage |

## Health Check Endpoints

### Application Health

```text
GET /health
```

Response:

```json
{
    "status": "Healthy",
    "version": "1.0.0",
    "uptime": "1.00:00:00",
    "dependencies": {
        "database": { "status": "Healthy" },
        "cache": { "status": "Healthy" }
    }
}
```

### Health Check Details (Production Only)

```text
GET /health/ready
```

Checks database connectivity, configuration validity.

## Monitoring Configuration

### Health Check Monitoring (External Service)

Configure an external monitoring service (UptimeRobot, Pingdom, etc.) to check:

- `https://api.circlefund.example.com/health` every 30 seconds
- Alert on 2 consecutive failures
- Alert types: Email, SMS, Slack (depending on severity)

### Docker Monitoring (cAdvisor / similar)

- Container CPU, memory, network I/O
- Container restart events
- Container uptime

### Database Monitoring

- Connection count and pool usage
- Slow query log (queries >1 second)
- Database replication lag (if replicated)
- Table size growth trends

## Alerting Rules

### Critical Alerts (Immediate)

- Database unavailable
- API unavailable (health check failures)
- Financial operation failure rate spike
- Security incident detected

### High Alerts (within 15 minutes)

- Error rate >1% for 5 minutes
- Response time >1 second for 5 minutes
- Disk usage >85%
- Background job failures

### Medium Alerts (within 1 hour)

- Warning level log entries spiking
- Certificate expiry within 7 days
- Unusual access patterns
- Reconciliation discrepancies

### Low Alerts (daily summary)

- Performance trends
- Storage usage trends
- Minor warning events

## Financial Operation Monitoring

Key principle: **every financial operation should be traceable through logs**:

```text
ContributionRequested → Contributed → LedgerEntryCreated → BalanceUpdated → NotificationSent
```

Monitor for gaps in this chain:

- Contribution recorded but no ledger entry? → Alert
- Ledger entry but no balance update? → Alert
- Balance updated but notification failed? → Warning
- All steps completed but audit missing? → Critical alert

## Dashboard Recommendations

### Phase 1 Dashboard (Spreadsheet / Simple Tool)

- System uptime percentage
- Error rate per day
- Response time average
- Daily contribution count and total amount
- Daily payout count and total amount
- Database size trend
- Active users count

### Phase 2 Dashboard (Grafana or equivalent)

- Real-time request rate
- Response time percentiles (p50, p95, p99)
- Error rate by endpoint
- Database query performance
- Background job status
- Business metrics (contributions by circle, payout distributions)

### Phase 3 Dashboard (Full observability)

- Distributed tracing visualization
- Service dependency map
- AI anomaly detection
- Business flow monitoring
