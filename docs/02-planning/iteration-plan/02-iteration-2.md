# Iteration Plan — Iteration 2 (Financial Operations)

**Sequence:** Payout Draw → Bidding → Rotation/No-Interest → Fixed Interest → Reconciliation → Debt → Ledger → P&L → Audit → Reports → Export → Offline-Aware Financial Handling.

## Sprint 5 — Payout Draw & Bidding
**Epics:** I2-E01 Payout Draw; I2-E02 Bidding. Test priority: calculation, concurrency, duplicate ops, winner determination, payout correctness — also under queued-offline conditions.

## Sprint 6 — Rotation, Interest, Reconciliation
**Epics:** I2-E03 Rotation; I2-E04 Fixed Interest; I2-E05 Reconciliation. Focus: financial rules, rounding, state transitions.

## Sprint 7 — Debt, Ledger, P&L, Audit, Reports, Export
**Epics:** I2-E06..I2-E11. Focus: append-only ledger, audit trail, reports, export.

## Sprint 8 — Offline-Aware Financial Handling
**Epic:** I2-E14. Focus: pending-sync marking, conflict escalation (no auto-merge), never treat unsynced records as authoritative.

**Release gate:** all financial operations traceable; calculations tested; audit available; reports reconcile with ledger; offline financial mutations behave safely.