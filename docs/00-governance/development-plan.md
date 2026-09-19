# Development Plan — CircleFund

## Development Method

CircleFund uses an incremental, Scrum-style approach. Five planned iterations deliver five independently releasable increments, each built on the previous (full detail in `docs/02-planning/iteration-plan.md`):

```text
Iteration 1  Offline-First Core ROSCA Management
Iteration 2  Financial Operations (Offline-Capable)
Iteration 3  Integrations (External Services)
Iteration 4  Group Collaboration & Governance
Iteration 5  Advanced Platform
```

The governing structural decision (see `docs/03-architecture/adr/ADR-001-offline-first.md`): **offline reliability is a day-1, cross-cutting foundation**, not a late add-on. The local operation queue and sync engine are built in Iteration 1, every financial operation inherits them in Iteration 2, and only after the core product is stable do integrations (Iteration 3), collaboration (Iteration 4), and back-office features (Iteration 5) arrive.

## Development Lifecycle

```text
Backlog → Refinement → Ready → In Progress → Code Review → CI → QA → UAT → Done
```

> A feature is not "done" when the code is written; it is done when implemented, tested, reviewed, documented, deployable, and operationally usable.

## Cross-Cutting Engineering Epics

These run across all iterations (and include offline reliability from Iteration 1):

```text
X-E01 Validation
X-E02 Authorization
X-E03 Observability
X-E04 Reliability (transactions, idempotency, concurrency, retries, outbox, background jobs, recovery — including offline sync from Iteration 1)
X-E05 Testing
```

## Definition of Ready

A story enters development only when:

- [ ] Business objective is clear
- [ ] Acceptance criteria are testable (incl. offline/sync criteria where financial)
- [ ] Dependencies identified
- [ ] UX requirements defined (incl. pending-sync, conflict states)
- [ ] Domain rules identified
- [ ] Permission requirements known
- [ ] Data requirements understood (incl. local-ID and sync-status fields)
- [ ] Technical uncertainty acceptable
- [ ] Story is estimable

## Definition of Done

A user story is **Done** only when:

- [ ] Acceptance criteria satisfied
- [ ] Backend implemented; frontend implemented when applicable
- [ ] Database migration complete and reversible
- [ ] Validation, authorization, and error handling implemented
- [ ] Unit, integration, API tests passing
- [ ] Relevant offline/sync, concurrency, and E2E tests passing
- [ ] Code reviewed; CI passing
- [ ] Documentation updated; audit implemented where required
- [ ] No known critical defects; deployable

## Financial & Offline Integrity Gate

For relevant iterations, additionally:

- [ ] Calculations verified; ledger reconciles
- [ ] Duplicate operations prevented; audit trail available
- [ ] Offline-queued financial mutations never silently overwrite a conflicting server record
- [ ] Pending-sync records visibly distinguished from confirmed records everywhere

## Technical Practices

- **Offline-first:** every Iteration 1–2 slice writes through the local queue and syncs; never retrofitted
- **Domain-first:** business rules in the domain/application layer
- **Financial consistency:** atomic transactions for multi-record operations
- **Auditability:** corrections via compensating transactions; no silent history changes
- **Security by design:** authorization considered at design time
- **Tested business rules:** calculations, state transitions, and authorization have automated tests
- **Small increments:** working increments over big-bang delivery