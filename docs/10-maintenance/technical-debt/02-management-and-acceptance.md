# Technical Debt — Management & Acceptance

**Index:** `docs/10-maintenance/technical-debt.md`

## Prioritization Order

1. Safety/Security — financial integrity, secrets, auth.
2. Functionality — blocks feature work.
3. Maintainability — hard to change.
4. Quality — affects users.
5. Efficiency — performance at scale.

## Resolution Mechanisms

| Mechanism | When |
| --- | --- |
| Refactor | tangled/large code |
| Add tests | coverage gaps |
| Update docs | stale docs |
| Upgrade deps | CVE / EOL |
| Improve infra | CI/CD, monitoring, backup |

## Capacity & Review

| Review | Frequency |
| --- | --- |
| Sprint review | every sprint |
| Tech-debt review | every iteration |
| Full audit | quarterly |
| Strategic review | annually |

Capacity: I1 ~20%, later ~10–15%.

## Acceptance Rules

New debt accepted only when it: enables higher-value work; is documented with a resolution plan; does not weaken financial integrity, security, auditability, or offline/sync safety. Never accept debt that reduces offline/sync safety or financial-test coverage.