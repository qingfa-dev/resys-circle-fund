# References

## Standards

| Reference | Title | Use in this project |
| --- | --- | --- |
| IEEE 29148-2018 | Systems and software engineering — Life cycle processes — Requirements engineering | Authoritative SRS structure (`01-requirements/srs.md`) |
| IEEE 830-1998 | Recommended Practice for Software Requirements Specifications | Legacy structural reference (superseded by 29148) |
| IEEE 1058 | Standard for Software Project Management Plans | Companion reference for planning docs |

## Internal Cross-References (canonical pointers)

| Pointer | Location |
| --- | --- |
| Master documentation index | `docs/README.md` |
| Software Requirements Specification (index) | `docs/01-requirements/srs.md` |
| Requirement Traceability Matrix | `docs/01-requirements/requirements-traceability.md` |
| Glossary (domain terms) | `docs/00-governance/glossary.md` |
| Architecture description | `docs/03-architecture/architecture-description.md` |
| ADR index (template + catalog) | `docs/03-architecture/adr/ADR-TEMPLATE.md` |
| Test strategy / test plan | `docs/06-verification/test-strategy.md`, `test-plan.md` |
| Release notes / plan | `docs/07-release/release-notes.md`, `release-plan.md` |

## Citation Style

- Requirements: `FR-<iter>-NNN`, `NFR-NNN`, `UC-<iter>-NNN`, `US-<iter>-NNN`, `BR-<category>-NNN`.
- Verification: `TC-<iter>-NNN`, `AT-<iter>-NNN`.
- Architecture: `ADR-NNN`.
- Actors: `ACT-NN`.

When citing a requirement in prose, use its ID (e.g., "FR-I1-041") — it resolves across `fr/`, `nfr/`, traceability matrices, and test plans.