# Financial Accounts — Functional Requirements

**Iteration:** 5 — Advanced Platform
**SRS:** `docs/01-requirements/srs.md` §3.5.1

## FR-I5-001

**Statement:** A user/group shall be able to create multiple financial accounts (Cash, Bank, E-wallet, Other).

## FR-I5-002

**Statement:** Each account shall maintain its own balance.

## FR-I5-003

**Statement:** Users shall be able to transfer money between supported accounts.

## FR-I5-004

**Statement:** Transfers shall create corresponding ledger records.

**Related:** UC-I5-001..005, US-I5-001..003, BR-FIN-002, NFR-006 (idempotent transfers)