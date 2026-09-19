# Offline-Aware Financial Handling — Use Cases

**Iteration:** 2 — Financial Operations (Offline-Capable)
**SRS:** `docs/01-requirements/srs.md` §3.2.12

## UC-I2-046 — Queue Offline Financial Mutation
**Actor:** Circle Organizer / Treasurer. Use local-ID/queue mechanism (FR-I2-047).

## UC-I2-047 — Flag Financial Sync Conflict
**Actor:** System. Detect conflicting offline mutation → require explicit reconciliation (FR-I2-048).

## UC-I2-048 — Reconcile Conflicting Financial Mutation
**Actor:** Treasurer. Manually reconcile; never auto-merge.

## Associated User Stories
- US-I2-020 — *As a Treasurer, I want to record a payout draw or contribution while offline so that a connectivity gap doesn't stop the circle's schedule.*
- US-I2-021 — *As a Circle Organizer, I want to see which financial records are still pending sync so that I don't mistake them for confirmed totals.*
- US-I2-022 — *As a Treasurer, I want to manually reconcile a conflicting offline financial mutation so that the ledger never silently picks the wrong version.*