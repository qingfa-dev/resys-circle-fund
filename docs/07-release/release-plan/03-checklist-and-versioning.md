# Release Plan — Checklist & Versioning

**Index:** `docs/07-release/release-plan.md`

## Pre-Release Checklist

- [ ] All features implemented and tested
- [ ] DB migrations tested (clean + existing) and reversible
- [ ] API contract verified
- [ ] Authorization tested
- [ ] Offline/sync + concurrency tests passing (I1/I2 releases)
- [ ] Documentation + release notes updated
- [ ] Deployment guide updated; rollback verified
- [ ] Backup verified; backup restore tested
- [ ] Monitoring active; alerting configured

## Versioning

Semantic versioning:

| Bump | When |
| --- | --- |
| MAJOR | breaking API/data-model/UX changes |
| MINOR | new features (non-breaking) |
| PATCH | bug/security fixes |

Tagging: `git tag -a v1.0.0 -m "Release v1.0.0"`.