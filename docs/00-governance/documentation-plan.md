# Documentation Plan — CircleFund

## Purpose

Defines documentation standards, ownership, structure, and the navigation apparatus for CircleFund.

## Documentation Standards

### Format
- Markdown, stored under `docs/`, decomposed by concern into numbered subfolders.
- Consistent structure: overview → detail → cross-references.

### Requirements Standard
- The SRS (`01-requirements/srs.md`) follows **IEEE 29148-2018**: Introduction (§1), Overall Description (§2), System Features with FR/UC/US per iteration (§3), External Interface Requirements (§4), Non-Functional Requirements (§5), Appendices (§A–D).
- Detail is split into `01-requirements/fr/` (per feature), `nfr/` (per NFR), `use-cases/` (per feature + user stories), `business-rules/` (per category).

### Terminology
- English domain terminology primary; Vietnamese mapped only in `glossary.md` and SRS Appendix D.

### ADRs
- `03-architecture/adr/`, following the template in `ADR-TEMPLATE.md` (status: Proposed / Accepted / Deferred / Superseded).

### Review
- All docs reviewed through the same PR process as code; technical docs need domain review; user docs need usability review.

## Navigation Apparatus

- `docs/README.md` — master index: Table of Contents, List of Tables, List of Figures, References, Appendix index, reading order for humans + agents.
- `docs/<NN-*>/README.md` — per-folder guide (purpose, key terms, contents, cross-references).
- `docs/00-governance/references.md` — bibliography + canonical cross-links.

## ID Scheme (stable, traceable)

`FR-<iter>-NNN` · `NFR-NNN` · `UC-<iter>-NNN` · `US-<iter>-NNN` · `BR-<cat>-NNN` · `TC-<iter>-NNN` · `AT-<iter>-NNN` · `ADR-NNN` · `ACT-NN`.

## Document Ownership

| Document Type | Owner |
| --- | --- |
| Project Charter | Project Owner |
| SRS / requirements | Product / Business Analyst |
| Architecture, ADRs | Lead Architect |
| Design | Design Lead |
| Test Plans | QA Lead |
| User Guides | Technical Writer / Product |
| Runbooks | Operations / DevOps |

## Maintenance

- Reviewed at end of each iteration; updated as part of Definition of Done.
- Documentation health check before each release.
- Indexes (`README.md`) regenerated when structure changes.