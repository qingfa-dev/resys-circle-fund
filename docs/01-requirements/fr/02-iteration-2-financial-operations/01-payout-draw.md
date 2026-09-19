# Payout Draw — Functional Requirements

**Iteration:** 2 — Financial Operations (Offline-Capable)
**SRS:** `docs/01-requirements/srs.md` §3.2.1

## FR-I2-001

**Statement:** The system shall allow authorized users to record a payout draw event.

## FR-I2-002

**Statement:** A payout draw shall reference Circle, Round, Member, Share, Payout Draw amount, Discount/interest, Net payout, Date, Actor.

## FR-I2-003

**Statement:** The system shall validate whether a member is eligible to payout draw.

**Acceptance Criteria:** Ineligible members are rejected (BR-PAY-001).

## FR-I2-004

**Statement:** The system shall prevent multiple incompatible payout draw events for the same round.

**Acceptance Criteria:** A second payout draw for the same round/member is rejected (BR-PAY-002).

## FR-I2-005

**Statement:** The system shall record the resulting payout.

**Acceptance Criteria:** The payout creates a ledger entry and updates the balance atomically (NFR-004).

**Related:** UC-I2-001..005, US-I2-001/002, BR-PAY-001..003, BR-FIN-002