# Offline-Aware Financial Handling — Functional Requirements

**Iteration:** 2 — Financial Operations (Offline-Capable)
**SRS:** `docs/01-requirements/srs.md` §3.2.12

> New in this reorganization — depends on offline capture being foundational in Iteration 1.

## FR-I2-047

**Statement:** Financial mutations captured offline shall use the same local-ID/queue mechanism defined in Iteration 1 (FR-I1-041 to 045).

## FR-I2-048

**Statement:** A conflicting offline financial mutation (e.g., two devices recording a payout draw for the same round) shall require explicit reconciliation rather than automatic merge (BR-SYN-002).

**Acceptance Criteria:** A conflicting financial mutation escalates to manual resolution; it is never auto-merged.

## FR-I2-049

**Statement:** A financial mutation recorded offline shall be visibly marked "pending sync" and shall not be treated as authoritative in balances, ledger, or reports until synchronized (BR-SYN-003).

**Related:** UC-I2-046..048, US-I2-020..022, BR-SYN-002..003, NFR-029