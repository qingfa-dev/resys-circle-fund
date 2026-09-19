# Rollback Plan — CircleFund

## Overview

This document defines the rollback procedure for CircleFund deployments. The plan ensures that a failed deployment can be quickly reverted to a stable state.

## Rollback Triggers

Initiate rollback when:

- [ ] Critical financial calculations produce incorrect results
- [ ] System is unavailable for >5 minutes during/after deployment
- [ ] Data loss or corruption detected
- [ ] Security vulnerability discovered in new release
- [ ] Critical bug discovered affecting core functionality
- [ ] More than 10% of users report issues post-deployment
- [ ] Monitoring alerts triggered (error rate, latency, etc.)

## Rollback Decision Matrix

| Scenario | Rollback? | Method | Time to Revert |
|----------|-----------|--------|----------------|
| DB migration failed | Yes | Code revert + DB restore | 15 minutes |
| DB migration not backward-compatible | Yes | DB restore from backup + code revert | 30 minutes |
| Code bug (non-DB) | Yes | Code revert | 5 minutes |
| Minor UI bug | No (fix in next release) | Hotfix | N/A |
| Performance regression | Yes | Code revert + config review | 15 minutes |
| Security issue | Yes | Code revert + investigation | 30 minutes |

## Rollback Procedures

### Scenario 1: Code Issue (No Database Migration Impact)

```text
1. Identify issue and trigger rollback decision
2. Notify stakeholders
3. Revert code to previous version tag
4. Redeploy
5. Verify functionality
6. Notify stakeholders of successful rollback
```

Steps:

```bash
# 1. Identify problematic release
git log --oneline -10

# 2. Revert to previous stable version
git checkout v0.0.9

# 3. Redeploy
docker compose -f docker-compose.production.yml up -d --force-recreate

# 4. Verify
curl https://api.circlefund.example.com/health
# Test critical paths manually
```

### Scenario 2: Database Migration Failed

```text
1. Stop new deployments
2. Assess database state
3. Restore database from backup (if data corrupted)
4. Revert code to previous version
5. Redeploy
6. Verify
```

Steps:

```bash
# 1. Stop new deployments (disable CI/CD pipeline)

# 2. Check database state
docker compose -f docker-compose.production.yml exec db \
  psql -U circlefund -d circlefund -c "\dt"

# 3. Restore from backup (if needed)
docker compose -f docker-compose.production.yml exec db \
  psql -U circlefund -d circlefund < /path/to/backup.sql

# 4. Revert code
git checkout v0.0.9

# 5. Redeploy
docker compose -f docker-compose.production.yml up -d --force-recreate

# 6. Verify
curl https://api.circlefund.example.com/health
```

### Scenario 3: Configuration Error

```text
1. Identify incorrect configuration
2. Revert to previous configuration values
3. Restart services (no code change needed)
4. Verify
```

## Rollback Verification

After rollback, verify:

- [ ] Health endpoint returns OK
- [ ] Login works
- [ ] Create circle works
- [ ] Record contribution works
- [ ] Balance calculations correct
- [ ] Dashboard displays correctly
- [ ] Monitoring shows error rate returning to baseline
- [ ] Database queries perform as expected
- [ ] No error spikes in logs

## Rollback Communication

### Internal

| Event | Audience | Method |
|-------|---------|--------|
| Rollback initiated | Technical team | Slack/Teams |
| Rollback in progress | Technical team | Real-time updates |
| Rollback complete | All stakeholders | Email/announcement |
| Root cause identified | Technical team | Incident review |

### External (if applicable)

| Event | Audience | Method |
|-------|---------|--------|
| Service degradation detected | Users | Status page |
| Service restored | Users | Status page update |
| Data loss (if any) | Affected users | Direct notification |

## Pre-Rollback Preparation

To ensure quick rollbacks:

- [ ] Previous version always running and tested
- [ ] Database backups verified and tested for restore
- [ ] Rollback procedure documented and rehearsed
- [ ] Configuration for previous version stored
- [ ] Database migrations backward-compatible (where possible)
- [ ] Monitoring and alerting active before new deployment

## Preventing Rollbacks

- [ ] Thorough testing before deployment (unit, integration, E2E)
- [ ] Staging environment mirrors production
- [ ] Gradual rollout (canary deployment, progressive)
- [ ] Feature flags for risky features
- [ ] Code review for all changes
- [ ] Database migrations tested on realistic data
