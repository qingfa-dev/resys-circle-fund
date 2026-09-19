# Synchronization Design — Principles

**Source:** `docs/04-design/synchronization-design.md` (index)
**ADRs:** `ADR-001`, `ADR-002`

Synchronization is a **day-1 foundation**, not an advanced feature (FR-I1-041 to 045, FR-I2-047 to 049).

## Principles

1. **Server-authoritative:** the server holds the final truth for financial records.
2. **Local capture first:** the client writes locally, syncs second.
3. **Idempotent operations:** every queued operation can be safely retried.
4. **FIFO queue:** operations synchronize in creation order.
5. **No silent discard:** conflicts are surfaced, never auto-merged.