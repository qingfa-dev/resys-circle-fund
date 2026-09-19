# Contribution — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.5

## FR-I1-028 — Record Contribution

**Statement:** The system shall allow an authorized actor to record a member contribution. Data includes: Circle, Round, Member, Share, Amount, Date, Payment method, Reference, Note, Recorded by.

**Acceptance Criteria:**
- Given valid data, When recorded, Then the contribution is committed with balance, ledger, and audit updates in one transaction (NFR-004).
- Given offline capture, When recorded, Then it is queued with a local ID and marked pending (FR-I1-041).

**Related:** UC-I1-029, US-I1-017, BR-CON-001..003, ADR-003/004

## FR-I1-029 — Payment Status

**Statement:** Each required contribution shall have a payment status (Unpaid, Partial, Paid, Overdue, Waived, Cancelled).

**Related:** UC-I1-030, US-I1-018, BR-CON-004

## FR-I1-030 — Contribution History

**Statement:** Users with appropriate permission shall be able to view contribution history.

**Related:** UC-I1-031

## FR-I1-031 — Duplicate Prevention

**Statement:** The system shall prevent accidental duplicate contribution records.

**Acceptance Criteria:** A duplicate (same member/share/round) is rejected; a replayed idempotency key returns the cached result.

**Related:** BR-CON-003, NFR-005/006, ADR-004

## FR-I1-032 — Correction

**Statement:** Authorized users shall be able to correct a financial record through a controlled reversal/correction mechanism rather than silently overwriting history.

**Related:** UC-I1-032/033, BR-CON-005, BR-FIN-002, ADR-003