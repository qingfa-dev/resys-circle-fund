# Balance — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.6

## FR-I1-033 — Member Balance

**Statement:** The system shall calculate each member's outstanding and completed obligations.

**Related:** UC-I1-034, US-I1-019, BR-FIN-003 (derived from ledger)

## FR-I1-034 — Round Collection

**Statement:** The system shall calculate the collection status of each round.

**Related:** UC-I1-035, US-I1-020

## FR-I1-035 — Overall Circle Balance

**Statement:** The system shall provide a summary balance for the circle.

**Related:** UC-I1-036

## FR-I1-036 — Recalculation

**Statement:** Balances shall be derived from authoritative transactions rather than manually edited totals.

**Acceptance Criteria:**
- Given ledger entries, When balance is read, Then it equals the deterministic sum of authoritative entries.
- Given a pending-sync record, When balance is computed, Then that record is excluded (FR-I2-049).

**Related:** UC-I1-037, BR-FIN-003, NFR-003 (Data Integrity)