# 01-requirements — README

## Purpose

The authoritative requirements corpus for CircleFund. Every functional, non-functional requirement, use case, user story, and business rule lives here, structured per IEEE 29148-2018. This is the source of truth all other folders support.

## Key Terms

- **FR (Functional Requirement)** — what the system must do (`FR-<iter>-NNN`).
- **NFR (Non-Functional Requirement)** — quality attributes (`NFR-NNN`).
- **UC (Use Case)** — an actor achieving a goal (`UC-<iter>-NNN`).
- **US (User Story)** — "As a … I want … so that" (`US-<iter>-NNN`), folded into use-case files.
- **BR (Business Rule)** — a domain invariant (`BR-<category>-NNN`).
- **Iteration** — one of five deliverable increments (1 Offline-Core … 5 Platform).

## Contents

```
01-requirements/
├── README.md                    this guide
├── srs.md                       IEEE 29148 index + appendices (A–D)
├── requirements-traceability.md requirement → design → test matrix
├── fr/                          45 feature files (per iteration)
│   ├── 01-iteration-1-offline-first-core/     (8)
│   ├── 02-iteration-2-financial-operations/   (12)
│   ├── 03-iteration-3-integrations/           (7)
│   ├── 04-iteration-4-group-collaboration/    (9)
│   └── 05-iteration-5-advanced-platform/      (9)
├── nfr/                         40 files, one per NFR
├── use-cases/                   45 files, per feature + user stories
├── use-cases index (use-cases.md)
└── business-rules/              8 category files (BR-*)
```

## Usage

- **Find a requirement:** open `srs.md` → follow the linked `fr/` or `nfr/` file; or grep the ID.
- **Trace coverage:** `requirements-traceability.md`.
- **Check an invariant:** `business-rules/`.
- **Check a use case / user story:** `use-cases/`.

## Cross-references

- Terminology: `../00-governance/glossary.md`
- Domain model: `../03-architecture/domain-model/`
- Tests: `../06-verification/`