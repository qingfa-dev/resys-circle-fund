# Rollback Plan — Communication & Preparation

**Index:** `docs/07-release/rollback-plan.md`

## Communication

| Event | Audience | Channel |
| --- | --- | --- |
| Rollback initiated | Technical team | real-time channel |
| In progress | Technical team | continuous updates |
| Complete | All stakeholders | announcement |
| Root cause | Technical team | incident review |

External: status page for degradation; direct notice if any data loss.

## Pre-Rollback Preparation

- [ ] Previous version still running/tested
- [ ] Verified DB backups (restore rehearsed)
- [ ] Rollback procedure documented and practiced
- [ ] Prior configuration values stored
- [ ] Migrations backward-compatible where possible
- [ ] Monitoring active before new deploy

## Preventing Rollbacks

- Thorough testing (unit/integration/E2E).
- Staging mirrors production.
- Gradual rollout (canary) + feature flags.
- Code review; migrations tested on realistic data.