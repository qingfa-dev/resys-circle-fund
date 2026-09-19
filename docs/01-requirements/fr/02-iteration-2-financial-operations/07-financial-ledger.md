# Financial Ledger — Functional Requirements

**Iteration:** 2 — Financial Operations (Offline-Capable)
**SRS:** `docs/01-requirements/srs.md` §3.2.7
**ADR:** `docs/03-architecture/adr/ADR-003-financial-ledger.md`

## FR-I2-029

**Statement:** The system shall maintain a financial ledger for authoritative financial events.

## FR-I2-030

**Statement:** Each ledger entry shall reference its originating business operation.

## FR-I2-031

**Statement:** Financial records shall be append-oriented (BR-FIN-002).

**Acceptance Criteria:** Ledger entries are never updated or deleted after creation.

## FR-I2-032

**Statement:** Corrections shall create reversal/correction entries rather than silently deleting the original (BR-FIN-002, ADR-003).

## FR-I2-033

**Statement:** The system shall support transaction references and correlation IDs.

**Related:** UC-I2-029..032, US-I2-011/012, BR-FIN-002, NFR-003/011