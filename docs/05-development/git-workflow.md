# Git Workflow — CircleFund

## Branch Strategy

### Main Branches

| Branch | Purpose | Protection |
|--------|---------|-----------|
| `main` | Production-ready code | Require PR reviews, all CI checks passing |
| `develop` | Integration branch for next release | Require PR reviews, CI checks passing |

### Feature Branches

All work is done in feature branches. Branch naming follows this pattern:

```text
feature/<iteration>-<epic>-<user-story>-<short-description>
```

Examples:

```text
feature/I1-E05-record-contribution
feature/I2-E01-record-hot
feature/I2-E03-determine-winner
bugfix/fix-balance-recalculation
hotfix/fix-payout-calculation
```

### Branch Lifecycle

```text
develop
  │
  ├── feature/I1-E05-record-contribution
  │     │
  │     ├── Development
  │     ├── Code Review
  │     ├── CI Passes
  │     │
  │     └── Merge to develop (Squash or Merge commit)
  │
  └── ...

develop
  │
  └── release/v0.2.0
        │
        ├── Final testing
        ├── Release candidate
        │
        └── Merge to main (tag v0.2.0)
```

### Hotfix Branches

For urgent production fixes:

```text
main
  │
  ├── hotfix/fix-critical-bug
  │     │
  │     ├── Fix + tests
  │     ├── Code Review
  │     ├── Fast-track CI
  │     │
  │     ├── Merge to main (tag vX.Y.Z+1)
  │     └── Merge to develop
```

## Pull Request Process

### Creating a PR

1. Push feature branch to remote
2. Open PR targeting `develop`
3. Use PR template (see below)
4. Assign reviewers (minimum 1 for normal, 2 for financial features)
5. Add appropriate labels
6. CI pipeline runs automatically

### PR Template

```text
## Summary

[What does this PR do?]

## Related Issues

Closes #123

## Type of Change

- [ ] New feature
- [ ] Bug fix
- [ ] Breaking change
- [ ] Documentation
- [ ] Test coverage
- [ ] Refactoring

## Checklist

- [ ] Acceptance criteria satisfied
- [ ] Tests added (unit, integration, API as applicable)
- [ ] Database migration included (if applicable)
- [ ] Authorization checked and implemented
- [ ] Validation added
- [ ] Error handling added
- [ ] Logging appropriate
- [ ] API documentation updated
- [ ] User documentation updated (if applicable)
- [ ] No secrets committed
- [ ] No unnecessary architectural changes
- [ ] Code reviewed by at least 1 approver
```

### Review Process

```text
Developer pushes branch
      ↓
Open PR
      ↓
Automated CI
      ├── Build
      ├── Lint / formatting
      ├── Unit tests
      ├── Integration tests
      ├── API tests
      └── Security scan
      ↓
Code Review
      ├── 1 reviewer (normal features)
      ├── 2 reviewers (financial features)
      ├── Domain expert (financial features)
      └── Approve / Request changes
      ↓
Fix review findings
      ↓
CI re-passes
      ↓
Merge
```

### Merge Strategies

| Scenario | Strategy |
|----------|---------|
| Feature branches | Squash merge (clean history) |
| Release branches | Rebase or merge commit |
| Hotfixes | Rebase onto main and develop |

### Merge Requirements

- [ ] All CI checks passing
- [ ] Minimum required reviews completed
- [ ] No unresolved merge conflicts
- [ ] No failing tests
- [ ] No TODO comments in merged code (unless with issue link)

## Commit Messages

Follow conventional commits format (see `docs/05-development/coding-standards.md`).

### Before Committing

- [ ] Code compiles
- [ ] Tests pass
- [ ] No secrets in code
- [ ] Change is focused (one logical change per commit)
- [ ] Commit message is descriptive

## Commit Example Flow

```text
git checkout -b feature/I1-E05-record-contribution

# ... implement feature ...

git add src/CircleFund.Application/Features/Contributions/RecordContribution/
git add tests/CircleFund.Tests/UnitTests/ContributionTests.cs
git commit -m "feat(contribution): record member contribution"

git push origin feature/I1-E05-record-contribution
# Open PR
```

## Tagging Releases

```text
git tag -a v0.2.0 -m "Release v0.2.0: Financial lifecycle features"
git push origin v0.2.0
```

Tags follow semantic versioning.
