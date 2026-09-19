# CircleFund Documentation — Master Index

> Rotating Savings and Credit Association (ROSCA / "Hụi") management platform — full engineering documentation.

This is the front-matter index for the CircleFund docs. It is organized like a thesis dissertation: a Table of Contents, List of Tables, List of Figures, a References section, and an Appendix index, so both a human developer and a future agent can navigate the corpus by structure and by term.

**Status:** Draft · **Baseline:** `brainstorms/draft-srd-v1.md` + `brainstorms/draft-plans-v1.md` · **Standard:** IEEE 29148-2018

---

## How to Use This Documentation

### For a human developer (reading order)

1. `00-governance/` — charter, glossary, standards (5 min orientation).
2. `01-requirements/srs.md` — the SRS index → then `fr/`, `nfr/`, `use-cases/`, `business-rules/` for full detail.
3. `03-architecture/` — domain model, data model, ADRs (how it's built).
4. `04-design/` — API, security, sync, UI (how it behaves).
5. `02-planning/` + `06-verification/` — roadmap, iterations, tests.
6. `05-development/`, `07-release/`, `08-operations/`, `09-user/`, `10-maintenance/` — reference as you build/deploy/run.

### For a future agent (navigation protocol)

- Every requirement carries a stable ID (`FR-*`, `NFR-*`, `UC-*`, `US-*`, `BR-*`, `TC-*`, `AT-*`, `ADR-*`, `ACT-*`). Trace any ID via `01-requirements/requirements-traceability.md`.
- Each folder has a `README.md` that states its **purpose**, **key terms**, **contents**, and **cross-references**. Start there before opening leaf files.
- Dictionary of all domain terms: `00-governance/glossary.md` (English primary, Vietnamese mapped).
- Authoritative requirement source: `01-requirements/srs.md` (+ its subfolders). Everything else is derived from or supports it.

---

## Table of Contents

- **00-governance/** — charter, development plan, documentation plan, glossary, references
- **01-requirements/** — the SRS and full requirement corpus
  - `srs.md` (IEEE 29148 index) · `requirements-traceability.md`
  - `fr/` — functional requirements, one file per feature, per iteration (Iterations 1–5)
  - `nfr/` — non-functional requirements, one file per NFR (NFR-001..040)
  - `use-cases/` — use cases + user stories, per feature, per iteration
  - `business-rules/` — domain invariants, per category
- **02-planning/** — roadmap (product-roadmap), iteration plan (per-iteration sprints), release plan
- **03-architecture/** — architecture description, domain model (per subdomain), data model (column-level), ADRs
- **04-design/** — API, security, synchronization, UI (each split by concern)
- **05-development/** — coding standards, git workflow, implementation notes
- **06-verification/** — test strategy, test plan, test cases (per iteration), acceptance tests (per iteration), traceability, `test-results/`
- **07-release/** — release plan, release notes, deployment guide, rollback plan
- **08-operations/** — runbook, monitoring, incident response, backup & recovery
- **09-user/** — user guide, administrator guide, FAQ
- **10-maintenance/** — change management, migration policy, technical debt

---

## List of Tables

| Table | Location |
| --- | --- |
| Domain terminology (English ↔ Vietnamese) | `00-governance/glossary.md` |
| Actors (Human ACT-01..10) | `01-requirements/srs.md` §2.3, `00-governance/glossary.md` |
| External/System actors (ACT-11..18) | `01-requirements/srs.md` §2.3 |
| Actor permission model | `01-requirements/srs.md` §2.3 |
| NFR catalog (NFR-001..040) | `01-requirements/nfr/`, `srs.md` §5 |
| NFR-by-iteration matrix (§5.41) | `01-requirements/srs.md` §5.41 |
| User Story catalog (Appendix A) | `01-requirements/srs.md` Appendix A |
| Requirement Traceability Matrix (Appendix B) | `01-requirements/srs.md` Appendix B, `requirements-traceability.md` |
| Actor-to-Iteration Matrix (Appendix C) | `01-requirements/srs.md` Appendix C |
| Glossary (Vietnamese terms, Appendix D) | `01-requirements/srs.md` Appendix D, `00-governance/glossary.md` |
| Business rules catalog (BR-\*) | `01-requirements/business-rules/` |
| Data model column specs (per table) | `03-architecture/data-model/` |
| Integrity constraints & indexes | `03-architecture/data-model/04-constraints-and-migration.md` |
| Password policy & JWT config | `04-design/security-design/02-authentication.md` |
| Role → permission matrix | `04-design/security-design/03-authorization.md` |
| Rate limits | `04-design/security-design/06-rate-limiting-audit.md` |
| Performance targets (NFR-007) | `01-requirements/nfr/007-performance.md` |
| Sync status indicator | `04-design/synchronization-design/05-read-cache-and-status.md` |
| Test case matrices (per iteration) | `06-verification/test-cases/` |

## List of Figures (diagrams)

| Figure | Location |
| --- | --- |
| System architecture layers | `03-architecture/architecture-description.md` |
| Core ROSCA domain tree | `03-architecture/domain-model/01-core-rosca.md` |
| Offline capture & sync flow | `04-design/synchronization-design/03-sync-flow.md`, `04-design/api-design/07-offline-sync.md` |
| Operation queue state machine | `04-design/synchronization-design/02-offline-queue.md` |
| Aggregate state machines (Circle/Round/Contribution) | `03-architecture/domain-model/01-core-rosca.md` |
| SDLC pipeline | `00-governance/development-plan.md` |
| Financial operation flow | `03-architecture/architecture-description.md` |
| End-to-end financial trace chain | `08-operations/monitoring/03-financial-tracing.md` |

## References

Full bibliography: `00-governance/references.md`. Key standards:

- IEEE 29148-2018 — requirements engineering (SRS baseline)
- IEEE 830-1998 — legacy SRS structure
- IEEE 1058 — software project management plans

## Appendices

| Appendix | Content | Location |
| --- | --- | --- |
| A | User story catalog index | `01-requirements/srs.md` |
| B | Requirement traceability matrix | `01-requirements/srs.md`, `requirements-traceability.md` |
| C | Actor-to-iteration matrix | `01-requirements/srs.md` |
| D | Glossary (Vietnamese terms) | `01-requirements/srs.md`, `00-governance/glossary.md` |
| — | ADR index | `03-architecture/adr/ADR-TEMPLATE.md` |
| — | NFR-by-iteration matrix | `01-requirements/srs.md` §5.41 |

## Conventions

- **ID scheme:** `FR-<iter>-NNN` (functional), `NFR-NNN`, `UC-<iter>-NNN`, `US-<iter>-NNN`, `BR-<category>-NNN`, `TC-<iter>-NNN`, `AT-<iter>-NNN`, `ADR-NNN`, `ACT-NN`.
- **Iterations:** 1 Offline-First Core · 2 Financial Operations · 3 Integrations · 4 Group Collaboration · 5 Advanced Platform.
- **Terminology:** English primary; Vietnamese mapped in the glossary only.
- **Money:** fixed-precision `decimal`, no floating-point.