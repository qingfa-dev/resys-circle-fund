# 03-architecture — README

## Purpose

How the system is structured: the overall architecture, the domain model (aggregates, invariants, state machines), the data model (column-level schema), and the record of architectural decisions (ADRs).

## Key Terms

- **Domain model** — business concepts and rules (aggregates, entities, value objects).
- **Data model** — PostgreSQL schema (tables, columns, constraints, indexes).
- **ADR** — Architecture Decision Record; why a decision was made.
- **Aggregate / invariant / state machine** — DDD concepts used throughout.

## Contents

```
03-architecture/
├── README.md
├── architecture-description.md  overview, offline-first, layers, stack
├── domain-model.md              index → domain-model/ (6 subdomain files)
├── data-model.md                index → data-model/ (4 column-level files)
└── adr/
    ├── ADR-001-offline-first.md        Accepted
    ├── ADR-002-sync-strategy.md        Accepted
    ├── ADR-003-financial-ledger.md     Accepted
    ├── ADR-004-idempotency.md          Accepted
    └── ADR-TEMPLATE.md                 template + ADR index
```

## Usage

- **Understand a concept:** `domain-model/<subdomain>.md`.
- **Understand a table/column:** `data-model/<file>.md`.
- **Understand a decision's rationale:** the ADR.

## Cross-references

- What it implements: `../01-requirements/`
- How it behaves: `../04-design/`
- Schema change rules: `../10-maintenance/migration-policy/`