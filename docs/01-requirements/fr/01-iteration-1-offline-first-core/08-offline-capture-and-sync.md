# Offline Capture & Synchronization — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.8
**ADR:** `docs/03-architecture/adr/ADR-001-offline-first.md`, `ADR-002-sync-strategy.md`

> Foundational to this iteration — every feature above is captured locally first and synchronized second.

## FR-I1-041 — Local Identifiers

**Statement:** Offline operations shall receive unique local identifiers so they can be safely reconciled after sync.

**Acceptance Criteria:**
- Given an offline operation, When captured, Then a unique local ID (UUID) and idempotency key are assigned.

**Related:** UC-I1-041/042, NFR-029

## FR-I1-042 — Automatic Synchronization

**Statement:** The system shall synchronize queued operations automatically when connectivity returns.

**Acceptance Criteria:** Queued operations replay in FIFO order and complete exactly once via idempotency.

**Related:** UC-I1-043, US-I1-024, BR-SYN-004

## FR-I1-043 — Conflict Detection

**Statement:** The system shall detect synchronization conflicts (e.g., the same share edited on two devices).

**Related:** UC-I1-044, BR-SYN-002

## FR-I1-044 — No Silent Overwrite

**Statement:** Conflicting operations shall not be silently overwritten — the user shall be shown both versions.

**Acceptance Criteria:** On conflict, both versions are presented and the user chooses; nothing is auto-merged.

**Related:** UC-I1-045, US-I1-025, BR-SYN-002

## FR-I1-045 — Sync Status Display

**Statement:** The system shall maintain and display synchronization status (pending / synced / conflict) per record.

**Related:** NFR-029.1, Data Model `SyncStatus`