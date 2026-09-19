# Payout Draw — Use Cases

**Iteration:** 2 — Financial Operations (Offline-Capable)
**SRS:** `docs/01-requirements/srs.md` §3.2.1

## UC-I2-001 — Record Payout Draw
Record draw event with circle/round/member/share/amount → validate → commit.

## UC-I2-002 — Validate Payout Draw Eligibility
Check member eligibility rules (BR-PAY-001).

## UC-I2-003 — Calculate Payout Draw Amount
Compute gross, discount/interest, net payout.

## UC-I2-004 — Record Payout
Persist resulting payout → ledger entry.

## UC-I2-005 — View Payout Draw History
Retrieve and display draw history.

## Associated User Stories
- US-I2-001 — *As a Circle Organizer, I want to record a payout draw event so that the round's result is formally recorded.*
- US-I2-002 — *As a Circle Organizer, I want the system to calculate the resulting payout so that financial records remain consistent.*