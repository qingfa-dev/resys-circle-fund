# Savings Circle — Use Cases

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.2

## UC-I1-008 — Create Savings Circle
**Actor:** Circle Organizer. Provide config → validate → create. **Post:** Active.

## UC-I1-009 — Configure ROSCA Type
**Actor:** Circle Organizer. Select type → collect type-specific config → validate.

## UC-I1-010 — View Circle
**Actor:** Circle Organizer / Circle Member. Render circle info.

## UC-I1-011 — Edit Circle
**Actor:** Circle Organizer. Modify config → validate → save.

## UC-I1-012 — Pause Circle
**Actor:** Circle Organizer. Pause → status change.

## UC-I1-013 — Close Circle
**Actor:** Circle Organizer. Close (no open rounds) → final reconciliation.

## UC-I1-014 — View Historical Circle
**Actor:** Authorized User. Retrieve archived data → display.

## Associated User Stories
- US-I1-006 — *As a Circle Organizer, I want to create a Savings Circle so that I can manage a new ROSCA group.*
- US-I1-007 — *As a Circle Organizer, I want to configure the ROSCA rules so that the system can calculate its rounds and obligations.*
- US-I1-008 — *As a user, I want to view circle details so that I can understand its current status.*
- US-I1-009 — *As a Circle Organizer, I want to close a completed circle so that no further normal transactions can be added.*