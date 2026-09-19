# 10-maintenance — README

## Purpose

How we maintain and evolve CircleFund over time: change management, database migration policy, and technical-debt tracking.

## Key Terms

- **Change management** — how changes are requested, assessed, approved, and documented.
- **Migration policy** — how schema changes stay safe, reversible, and production-ready.
- **Technical debt** — register, prioritization, and acceptance rules.

## Contents

```
10-maintenance/
├── README.md
├── change-management.md    index → change-management/ (2)
├── migration-policy.md     index → migration-policy/ (2)
└── technical-debt.md       index → technical-debt/ (2)
```

## Usage

- **Propose a change:** `change-management/`.
- **Change the schema:** `migration-policy/`.
- **Track/accept debt:** `technical-debt/`.

## Cross-references

- Schema details: `../03-architecture/data-model/`
- Requirements affected by a change: `../01-requirements/`
- Release impact: `../07-release/`