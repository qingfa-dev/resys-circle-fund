# Product Roadmap — Phases 1–3

## Phase 1 — Offline-First Core

**Objective:** replace the paper ROSCA ledger with an offline-capable system.

**Success criteria:**
- Create circle → add members → generate rounds → record payments → see balances, fully offline.
- Offline capture + exactly-once sync verified.
- Duplicate prevention works; balances verified against manual calculation.

## Phase 2 — Financial Operations

**Objective:** complete financial operations on the Iteration 1 sync engine.

**Success criteria:**
- All financial operations traceable.
- Calculations verified (unit/integration/concurrency).
- Bidding/payout tested end-to-end.
- Conflict escalation (not auto-merge) verified.

## Phase 3 — Integrations

**Objective:** connect to the outside world with graceful degradation.

**Success criteria:**
- Each integration has a documented failure mode + degradation test.
- Failed notification never rolls back a committed transaction.
- Failed AI call never blocks manual entry.
- Failed backup detected and alerted.