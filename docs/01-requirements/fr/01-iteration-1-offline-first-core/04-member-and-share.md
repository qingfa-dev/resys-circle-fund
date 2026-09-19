# Member & Share Management — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.4

## FR-I1-021 — Add Member

**Statement:** A Circle Organizer shall be able to add a member to a circle.

**Related:** UC-I1-021, US-I1-010, BR-MEM-001, BR-CIR-005

## FR-I1-022 — Member Status

**Statement:** A member shall have a status (Active, Suspended, Removed, Completed).

**Related:** UC-I1-023/024, BR-MEM-002

## FR-I1-023 — Member Profile

**Statement:** Authorized users shall be able to view member information.

**Related:** UC-I1-022, NFR-018

## FR-I1-024 — Assign Share

**Statement:** The system shall associate one or more shares with a member.

**Related:** UC-I1-025, US-I1-011, BR-MEM-003

## FR-I1-025 — Multiple Shares

**Statement:** A member may own multiple shares when permitted by circle rules.

**Related:** UC-I1-026, BR-MEM-001

## FR-I1-026 — Transfer Share

**Statement:** An authorized user shall be able to transfer a share according to business rules.

**Related:** UC-I1-027, BR-MEM-004

## FR-I1-027 — Membership History

**Statement:** Changes to membership and share ownership shall be traceable.

**Related:** UC-I1-028, BR-AUD-001, NFR-011 (Auditability)