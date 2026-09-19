# Round Scheduling — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.3

## FR-I1-015 — Generate Rounds

**Statement:** The system shall generate rounds according to the configured schedule.

**Acceptance Criteria:**
- Given a circle's schedule, When generation is triggered, Then rounds are created matching frequency and number.

**Related:** UC-I1-015, US-I1-014, BR-CIR-003

## FR-I1-016 — Round Numbering

**Statement:** Each generated round shall have a unique sequential number.

**Related:** UC-I1-015, Data Model `Rounds.RoundNumber` (unique per circle)

## FR-I1-017 — Round Date

**Statement:** Each round shall have a scheduled date.

**Related:** UC-I1-015/020, Data Model `Rounds.ScheduledDate`

## FR-I1-018 — Round Status

**Statement:** A round shall support states: Scheduled, Open, Completed, Closed, Cancelled.

**Acceptance Criteria:** State transitions follow `Scheduled → Open → Completed → Closed`.

**Related:** UC-I1-017/018/019, BR-CIR-002

## FR-I1-019 — View Schedule

**Statement:** Users shall be able to view upcoming and historical rounds.

**Related:** UC-I1-016, US-I1-015

## FR-I1-020 — Modify Schedule

**Statement:** Authorized users shall be able to modify permitted schedule information.

**Acceptance Criteria:** A closed round's date cannot be changed; adjustments are permitted only while Scheduled.

**Related:** UC-I1-020, US-I1-016