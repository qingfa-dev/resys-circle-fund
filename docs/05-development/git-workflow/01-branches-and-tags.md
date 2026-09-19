# Git Workflow — Branches & Tags

**Index:** `docs/05-development/git-workflow.md`

## Branches

| Branch | Purpose | Protection |
| --- | --- | --- |
| `main` | production-ready | PR reviews + all CI green |
| `develop` | integration for next release | PR reviews + CI green |
| `feature/<iter>-<epic>-<story>-<desc>` | e.g. `feature/I1-E05-record-contribution` | — |
| `hotfix/<desc>` | urgent fixes | fast-track review |

## Release Tags

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

Semantic versioning: MAJOR.MINOR.PATCH.

## Branch Lifecycle

```text
develop
  ├── feature/...  → review → CI → merge to develop (squash)
  └── release/vX   → final test → merge to main (tag vX) → back-merge develop
main
  └── hotfix/...   → merge main (tag patch) → back-merge develop
```