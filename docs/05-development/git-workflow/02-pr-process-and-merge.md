# Git Workflow — PR Process & Merge

**Index:** `docs/05-development/git-workflow.md`

## PR Lifecycle

```text
push branch → open PR → CI (build/lint/unit/integration/API/security)
  → code review (1 reviewer; 2 + domain expert for financial features)
  → fix findings → CI re-pass → merge
```

## PR Template

```text
## Summary         — what/why
## Related         — Closes #123
## Type            — feature/bugfix/breaking/docs/test/refactor
## Checklist
- [ ] acceptance criteria satisfied
- [ ] tests added (unit/integration/API + offline/sync where financial)
- [ ] migration included + reversible
- [ ] authorization checked; validation + error handling added
- [ ] API + user docs updated
- [ ] no secrets; no unnecessary architectural changes
```

## Merge Strategies
- Feature → squash merge (clean history).
- Release → rebase or merge commit.
- Hotfix → rebase onto main + back-merge into develop.

## Merge Requirements
CI green; required reviews; no conflicts; no failing tests; no TODO without issue link.

## Commit Messages
Conventional commits: `feat(scope):`, `fix(scope):`, `test(scope):`, `docs(scope):`, `refactor(scope):`, `chore(scope):`.