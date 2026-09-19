# Integration Degradation Rules — Business Rules

**Category:** Integration Degradation (Iteration 3)

## BR-INT-001 — Notification
A failed notification never rolls back the originating business operation (FR-I3-005).

## BR-INT-002 — AI
AI produces proposals only; the user confirms; AI never commits directly (FR-I3-018, NFR-030).

## BR-INT-003 — Backup
A failed backup is detected and alerted, not silently skipped.