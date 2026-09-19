# Balance — Use Cases

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.6

## UC-I1-034 — View Member Balance
**Actor:** Circle Organizer / Circle Member. Derive from ledger → display.

## UC-I1-035 — View Round Balance
**Actor:** Circle Organizer. Calculate collection status → display.

## UC-I1-036 — View Circle Balance
**Actor:** Circle Organizer. Aggregate → display.

## UC-I1-037 — Recalculate Balance
**Actor:** System. Derive from ledger → refresh read model. Excludes pending-sync records (FR-I2-049).

## Associated User Stories
- US-I1-019 — *As a Circle Member, I want to view my own balance so that I understand what I've paid and what I still owe.*
- US-I1-020 — *As a Circle Organizer, I want to view the collection status of a round so that I can see who has paid and who hasn't.*