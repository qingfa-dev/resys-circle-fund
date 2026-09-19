# 07-release — README

## Purpose

How CircleFund ships: release plan (iteration → release mapping, gates), release notes, deployment guide, and rollback plan.

## Key Terms

- **Release Plan** — 5 releases (1.0…5.0), process, quality gates, checklist.
- **Deployment Guide** — prerequisites, Docker Compose, env vars, steps, troubleshooting.
- **Rollback Plan** — triggers, procedures, communication.
- **Release Notes** — what changed per release.

## Contents

```
07-release/
├── README.md
├── release-plan.md             index → release-plan/
├── release-notes.md            template + release history
├── deployment-guide.md         index → deployment-guide/ (3)
└── rollback-plan.md            index → rollback-plan/ (3)
```

## Usage

- **Plan a release:** `release-plan/`.
- **Deploy:** `deployment-guide/01-prerequisites.md` → `02-deployment-steps.md`.
- **Revert a bad deploy:** `rollback-plan/`.
- **Write release notes:** follow `release-notes.md` template.

## Cross-references

- What ships in each release: `../02-planning/release-plan/`
- Running the system: `../08-operations/`