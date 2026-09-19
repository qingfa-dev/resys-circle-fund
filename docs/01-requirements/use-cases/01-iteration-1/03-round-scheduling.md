# Round Scheduling — Use Cases

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.3

## UC-I1-015 — Generate Rounds
**Actor:** Circle Organizer. Trigger → create rounds per schedule → number sequentially.

## UC-I1-016 — View Round Schedule
**Actor:** Circle Organizer / Circle Member.

## UC-I1-017 — Open Round
**Actor:** Circle Organizer. Open scheduled round.

## UC-I1-018 — Complete Round
**Actor:** Circle Organizer. Verify contributions due → complete.

## UC-I1-019 — Close Round
**Actor:** Circle Organizer. Close completed round.

## UC-I1-020 — Adjust Round Date
**Actor:** Circle Organizer. Change scheduled date → validate (only while Scheduled).

## Associated User Stories
- US-I1-014 — *As a Circle Organizer, I want the system to generate the round schedule automatically so that I don't have to calculate periods manually.*
- US-I1-015 — *As a user, I want to view the upcoming and historical round schedule so that I know when payments and payouts are due.*
- US-I1-016 — *As a Circle Organizer, I want to adjust a permitted round date so that the schedule can reflect real-world exceptions.*