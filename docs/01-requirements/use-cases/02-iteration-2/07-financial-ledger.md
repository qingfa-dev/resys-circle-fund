# Financial Ledger — Use Cases

**Iteration:** 2 — Financial Operations (Offline-Capable)
**SRS:** `docs/01-requirements/srs.md` §3.2.7
**ADR:** `docs/03-architecture/adr/ADR-003-financial-ledger.md`

## UC-I2-029 — Create Ledger Entry
Append an authoritative financial entry.

## UC-I2-030 — View Ledger
View ledger entries with filters.

## UC-I2-031 — Reverse Transaction
Create a compensating reversal entry (no delete/modify).

## UC-I2-032 — Trace Transaction
Trace a transaction via reference and correlation ID.

## Associated User Stories
- US-I2-011 — *As a Circle Organizer, I want a financial ledger so that every transaction is recorded and traceable.*
- US-I2-012 — *As a Treasurer, I want to reverse or correct a transaction via a compensating entry so that the original history is preserved.*