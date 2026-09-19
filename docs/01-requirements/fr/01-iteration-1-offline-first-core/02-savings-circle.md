# Savings Circle — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.2

## FR-I1-008 — Create Circle

**Statement:** The system shall allow an authorized user to create a Savings Circle. The circle includes configurable: Circle Name, Association Type, Start Date, Frequency, Number of Rounds, Number of Shares, Contribution Amount, Round Date, Rules, Status.

**Acceptance Criteria:**
- Given valid configuration, When the Circle Organizer creates the circle, Then it is created in Active state.
- Given a missing required field or duplicate name, When submitted, Then creation is rejected.

**Related:** UC-I1-008, US-I1-006, BR-CIR-003/005, NFR-001

## FR-I1-009 — ROSCA Type

**Statement:** The system shall support the types: No-Interest Rotation, Fixed Interest, Bidding.

**Related:** UC-I1-009, US-I1-007, BR-CIR-004

## FR-I1-010 — View Circle

**Statement:** The system shall display circle information, membership, rounds, and financial summary.

**Related:** UC-I1-010, US-I1-008

## FR-I1-011 — Edit Circle

**Statement:** Authorized users shall be able to modify permitted circle configuration.

**Related:** UC-I1-011, BR-CIR-003; edits audited (BR-AUD-001)

## FR-I1-012 — Pause Circle

**Statement:** An authorized user shall be able to temporarily suspend selected operations.

**Acceptance Criteria:** When paused, no new contributions may be recorded; status changes to Paused.

**Related:** UC-I1-012, BR-CIR-002

## FR-I1-013 — Close Circle

**Statement:** An authorized user shall be able to close a completed circle.

**Related:** UC-I1-013, BR-CIR-002

## FR-I1-014 — Archive Circle

**Statement:** Closed circle data shall remain accessible as historical records according to retention rules.

**Related:** UC-I1-014, NFR-019 (Data Retention)