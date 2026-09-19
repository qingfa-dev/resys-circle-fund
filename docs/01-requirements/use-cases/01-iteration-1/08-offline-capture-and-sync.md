# Offline Capture & Synchronization — Use Cases

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.8

## UC-I1-041 — Record Offline Transaction
**Actor:** Circle Organizer / Treasurer. Capture locally → assign local ID → queue. **Post:** pending.

## UC-I1-042 — Queue Operation
**Actor:** System. Enqueue with local ID + idempotency key.

## UC-I1-043 — Synchronize
**Actor:** System. On connectivity → replay FIFO → mark synced.

## UC-I1-044 — Detect Conflict
**Actor:** System. Compare local vs server → flag conflict.

## UC-I1-045 — Resolve Conflict
**Actor:** Circle Organizer / Treasurer. Show both versions → choose → reconcile.

## Associated User Stories
- US-I1-023 — *As a Circle Organizer, I want to keep recording contributions even without signal so that a market stall or a village visit doesn't stop me from doing my job.*
- US-I1-024 — *As a user, I want offline entries to sync automatically the moment I'm back online so that I don't have to remember to do it manually.*
- US-I1-025 — *As a Circle Organizer, I want to be shown both versions of a conflicting record so that I decide which one is correct instead of the app guessing.*