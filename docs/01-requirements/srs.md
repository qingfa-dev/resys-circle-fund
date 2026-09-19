# Software Requirements Specification — Index

## Rotating Savings and Credit Association (ROSCA) Management Platform

**Prepared in accordance with IEEE 29148-2018.** This file is the authoritative SRS index; detailed requirements are split by concern into the subfolders below (see the decomposition note at the end).

**Author:** Project Team · **Version:** 5.0

### Document Control

| Version | Change |
| --- | --- |
| 5.0 | Restructured to 5 iterations; offline-first; IEEE 29148; decomposed into per-entity files |

---

## 1. Introduction

### 1.1 Purpose
Defines the complete functional and non-functional requirements for a ROSCA management platform (Vietnamese "Hụi"). This index is the authoritative requirements baseline.

### 1.2 Scope
Five independently releasable iterations:

```text
Iteration 1  Offline-First Core ROSCA Management
Iteration 2  Financial Operations (Offline-Capable)
Iteration 3  Integrations (External Services)
Iteration 4  Group Collaboration & Governance
Iteration 5  Advanced Platform
```

### 1.3 References
IEEE 29148-2018; IEEE 830-1998 (legacy); IEEE 1058. Glossary: `docs/00-governance/glossary.md`.

---

## 2. Overall Description (summary)

- **Product:** offline-first mobile/web app with a server-side API and PostgreSQL.
- **Actors:** ACT-01 Visitor, ACT-02 Registered User, ACT-03 Circle Organizer, ACT-04 Circle Member, ACT-05 Treasurer, ACT-06 Secretary, ACT-07 Group Owner, ACT-08 Group Moderator, ACT-09 Viewer, ACT-10 System Administrator; ACT-11 Notification Service, ACT-12 File Storage Service, ACT-13 Scheduler, ACT-14 Authentication Provider, ACT-15 Analytics/Reporting Engine, ACT-16 AI Service, ACT-17 Backup Storage, ACT-18 Subscription Provider.
- **Permission model:** `Authentication → User → Group Membership → Role → Permission → Resource Ownership → Action`.
- **Constraints:** core financial functions usable offline; financial mutations auditable and reversible; integrations degrade gracefully.

---

## 3. System Features (index)

### Functional Requirements (`fr/`)
- **Iteration 1** — `fr/01-iteration-1-offline-first-core/` (8 feature files)
- **Iteration 2** — `fr/02-iteration-2-financial-operations/` (12 feature files)
- **Iteration 3** — `fr/03-iteration-3-integrations/` (7 feature files)
- **Iteration 4** — `fr/04-iteration-4-group-collaboration/` (9 feature files)
- **Iteration 5** — `fr/05-iteration-5-advanced-platform/` (9 feature files)

### Use Cases (`use-cases/`)
Grouped per feature per iteration, with associated user stories folded in:
`use-cases/01-iteration-1/` … `use-cases/05-iteration-5/` (45 files).

### User Stories
User stories are co-located with their feature's use cases (see each `use-cases/**` file) and referenced from every FR.

### Business Rules (`business-rules/`)
`01-circle` … `08-integration` (see `business-rules.md` index).

---

## 4. External Interface Requirements

- **User interfaces:** mobile (iOS/Android) and web; core financial screens work offline with a pending-sync indicator (FR-I1-045, FR-I2-049). See `docs/04-design/ui-design/`.
- **Software interfaces (I3):** Notification Service, File Storage Service, Authentication Provider, AI Service, Analytics/Reporting Engine, Subscription Provider, Backup Storage. See `fr/03-iteration-3-integrations/` and `docs/04-design/api-design/`.
- **Communication interfaces:** HTTPS/REST; offline queue replays operations on connectivity (FR-I1-041 to 045).

---

## 5. Non-Functional Requirements (index)

NFRs are one per file under `nfr/` (`001-security.md` … `040-versioning.md`). Categories: Security, Financial Security, Data Integrity, Transaction Consistency, Concurrency, Idempotency, Performance, Scalability, Availability, Reliability, Auditability, Maintainability, Testability, Usability, Accessibility, Internationalization, Localization, Data Privacy, Data Retention, Backup, Disaster Recovery, Observability, Logging, API Consistency, API Documentation, Compatibility, Import Reliability, Export Reliability, Offline Reliability, AI Safety, File Security, Notification Reliability, Background Jobs, Search, Pagination, Sorting/Filtering, Error Handling, Deployment, Portability, Versioning.

See the per-iteration matrix in `nfr/` summary (also reproduced in `docs/06-verification/requirements-traceability.md`).

---

## Appendix A: User Story Catalog Index

- I1: US-I1-001 to 025 · I2: US-I2-001 to 022 · I3: US-I3-001 to 013 · I4: US-I4-001 to 021 · I5: US-I5-001 to 017. Located in `use-cases/**`.

## Appendix B: Requirement Traceability Matrix

See `requirements-traceability.md`.

## Appendix C: Actor-to-Iteration Matrix

See `requirements-traceability.md` and `docs/00-governance/glossary.md`.

## Appendix D: Glossary — Vietnamese Terms

See `docs/00-governance/glossary.md`.

---

## Decomposition Note

This index replaced the former monolithic `srs.md`, `use-cases.md`, and `business-rules.md`. Detail now lives in:

- `fr/` — one file per Feature (grouped, related FRs together; zero-padded, iteration-ordered)
- `nfr/` — one file per NFR
- `use-cases/` — one file per Feature's use cases (a group of related UCs), with user stories folded in
- `business-rules/` — one file per category of business rules

Every requirement ID remains stable and is cross-referenced across these files and the traceability matrices.