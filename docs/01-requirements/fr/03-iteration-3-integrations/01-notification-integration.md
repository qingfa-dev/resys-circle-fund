# Notification Integration — Functional Requirements

**Iteration:** 3 — Integrations (External Services)
**SRS:** `docs/01-requirements/srs.md` §3.3.1

## FR-I3-001

**Statement:** The system shall deliver notifications through the connected Notification Service (email, push, SMS).

## FR-I3-002

**Statement:** The system shall support per-user notification channel preferences.

## FR-I3-003

**Statement:** The system shall retry failed notification deliveries according to a bounded retry policy.

## FR-I3-004

**Statement:** The system shall record delivery status per notification.

## FR-I3-005

**Statement:** A failed notification delivery shall not roll back or block the originating business operation (BR-INT-001).

**Related:** UC-I3-001..005, US-I3-001/002, BR-INT-001, NFR-032