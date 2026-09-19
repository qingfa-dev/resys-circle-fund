# Change Management — Emergency & Documentation

**Index:** `docs/10-maintenance/change-management.md`

## Emergency Change Process

1. Identify issue + severity.
2. Assess impact/urgency.
3. Implement hotfix in `hotfix/<desc>`.
4. Minimal verification.
5. Review (≥1 team member).
6. Deploy immediately.
7. Document after deploy.
8. Back-merge to `develop`.
9. Post-incident review.

## Documentation Updates (which doc when)

| Change | Update |
| --- | --- |
| Functional requirements | `docs/01-requirements/srs/` + `fr/` |
| Business rules | `docs/01-requirements/business-rules/` |
| Architecture | `03-architecture/` + new ADR |
| API contract | `04-design/api-design/` |
| Test scope | `06-verification/` |
| Release | `07-release/release-notes/plan` |
| User-facing | `09-user/` |

## Rejecting Changes
Reject when: conflicts with objectives; unacceptable risk; not testable; violates core principles (financial consistency, auditability, offline safety); infeasible. Document reasons for future reference.