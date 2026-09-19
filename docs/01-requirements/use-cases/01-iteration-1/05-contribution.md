# Contribution — Use Cases

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.5

## UC-I1-029 — Record Contribution
**Actor:** Circle Organizer / Treasurer. Record → validate (amount/member/round/duplicate) → commit transaction → update balance → ledger entry.

## UC-I1-030 — View Payment Status
**Actor:** Circle Organizer / Circle Member.

## UC-I1-031 — View Contribution History
**Actor:** Authorized User.

## UC-I1-032 — Correct Contribution
**Actor:** Authorized User. Reversal + correction entries → recalculate.

## UC-I1-033 — Reverse Contribution
**Actor:** Authorized User. Reversal entry → recalculate.

## Associated User Stories
- US-I1-017 — *As a Circle Organizer or Treasurer, I want to record a member's contribution so that the round's payment status stays accurate.*
- US-I1-018 — *As a Circle Member, I want to see my payment status for each round so that I know whether I still owe a contribution.*