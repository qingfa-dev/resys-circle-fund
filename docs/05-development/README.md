# 05-development — README

## Purpose

How we write code: coding standards (naming, structure, offline conventions), the git workflow (branches, PRs, merges), and implementation notes (concrete patterns and pseudocode).

## Key Terms

- **Coding standards** — terminology, naming, structure, error/money/testing rules.
- **Git workflow** — branch strategy, PR process, merge/tag conventions.
- **Implementation notes** — offline queue, sync engine, financial transaction pattern.

## Contents

```
05-development/
├── README.md
├── coding-standards.md       index → coding-standards/ (3)
├── git-workflow.md           index → git-workflow/ (2)
└── implementation-notes.md   index → implementation-notes/ (2)
```

## Usage

- **Before writing code:** `coding-standards/`.
- **Before a PR:** `git-workflow/`.
- **For a concrete pattern (queue/sync/financial):** `implementation-notes/`.

## Cross-references

- What to build: `../01-requirements/`, `../04-design/`
- How to verify: `../06-verification/`