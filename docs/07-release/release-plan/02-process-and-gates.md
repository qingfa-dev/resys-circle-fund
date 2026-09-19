# Release Plan — Process & Gates

**Index:** `docs/07-release/release-plan.md`

## Release Process

```text
Feature complete → Regression → Release candidate → Staging → UAT
→ Release approval → Production → Smoke test → Monitoring
```

## Product Quality Gates

| Gate | Check |
| --- | --- |
| 1 Requirements | acceptance criteria satisfied |
| 2 Architecture | ADRs + design docs current |
| 3 Development | Definition of Done satisfied |
| 4 Quality | all test layers passing |
| 5 Security | dependency scan, authorization tests |
| 6 Financial & Offline Integrity | calc verified; ledger reconciles; no duplicate ops; audit available; offline-queued financial mutations never silently overwrite conflicts; pending-sync visibly distinguished |
| 7 Release | full release checklist |