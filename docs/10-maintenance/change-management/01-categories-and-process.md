# Change Management — Categories & Process

**Index:** `docs/10-maintenance/change-management.md`

## Categories & Approval

| Category | Example | Approval |
| --- | --- | --- |
| Standard | bug fix, UI text | Team Lead |
| Major | new feature, schema change | Product Owner + Tech Lead |
| Emergency | security patch, critical financial bug | Incident Commander |
| Architecture | subsystem change | Lead Architect + Product Owner |
| Financial rule | calculation/ledger rule | Product Owner + Domain Expert |

## Change Request Process

1. **Initiation** — owner, team, users, ops.
2. **Assessment** — business impact, technical complexity, risk/blast radius, dependencies, timeline, cost.
3. **Prioritization** — value, urgency, risk-reduction, capacity.
4. **Approval** — per matrix.
5. **Implementation** — dev → review → test → doc → deploy → verify.
6. **Documentation** — update the affected docs (SRS, business rules, ADR, API, test plan, release notes, user docs).