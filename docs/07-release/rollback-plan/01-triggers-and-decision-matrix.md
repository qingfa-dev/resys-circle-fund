# Rollback Plan — Triggers & Decision Matrix

**Index:** `docs/07-release/rollback-plan.md`

## Rollback Triggers
Incorrect financial calculations; outage >5 min; data loss/corruption; security vulnerability; critical bug; >10% user reports; monitoring alerts.

## Decision Matrix

| Scenario | Method | Time |
| --- | --- | --- |
| DB migration failed | Revert + DB restore | 15 min |
| Non-backward-compatible migration | DB restore + revert | 30 min |
| Code bug | Code revert | 5 min |
| Performance regression | Revert + config review | 15 min |
| Security issue | Revert + investigation | 30 min |