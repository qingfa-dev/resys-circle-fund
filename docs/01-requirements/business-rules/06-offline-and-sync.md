# Offline & Synchronization Rules — Business Rules

**Category:** Offline & Synchronization

## BR-SYN-001 — Local ID
Offline operations receive unique local identifiers for safe reconciliation (FR-I1-041).

## BR-SYN-002 — No Silent Overwrite
Conflicting operations surface both versions; user resolves (FR-I1-044, FR-I2-048).

## BR-SYN-003 — Pending-Sync Authority
A financial record marked "pending sync" is not authoritative in balances, ledger, or reports until synced (FR-I2-049).

## BR-SYN-004 — Exactly-Once
Synchronization replays operations exactly once via idempotency keys.