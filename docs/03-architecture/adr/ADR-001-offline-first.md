# ADR-001: Offline-First Approach

## Status

Deferred (Phase 4)

## Context

CircleFund is designed as a PWA, and mobile users may have unreliable connectivity. The initial release targets users with reliable internet, but offline capability is desired for the platform phase. Financial operations introduce unique challenges for offline mode:

- Duplicate transactions when connectivity resumes
- Retry handling for failed operations
- Conflicting changes between local and server state
- Idempotency of financial operations
- Synchronization ordering
- Conflict resolution between offline and online edits

## Decision

CircleFund adopts a **progressive offline** approach rather than full offline-first from the start:

1. **Phase 1-3 (No offline):** All operations require server connectivity. The server is the single source of truth for all financial data.

2. **Phase 4 (Progressive offline):** Selected read operations are cacheable for offline viewing. Selected write operations can be queued locally and synchronized when connectivity returns.

### Offline Scope (Phase 4)

**Available offline (read-only cache):**

- Circle summaries and current balances
- Recent contribution history
- Upcoming period schedules
- Member lists

**Queueable offline (write):**

- Contribution recording
- Simple data entry operations

**Not available offline:**

- Complex financial calculations
- Payout authorization
- Bidding
- Reconciliation
- Configuration changes

### Synchronization Model

1. Operations performed offline receive a local UUID as a temporary identifier
2. Each queued operation is stored in a local sync queue
3. When connectivity returns, queued operations are sent to the server in order
4. The server validates each operation idempotently using the operation's unique key
5. The server responds with the authoritative result
6. The client updates its local state based on the server response
7. Conflicts are surfaced to the user for resolution

## Consequences

### Positive

- Users in areas with unreliable connectivity can still perform some operations
- Gradual rollout reduces complexity and risk
- Server-authoritative model prevents financial inconsistencies in the initial release
- Idempotency at the API layer supports safe retry during sync

### Negative

- Users may expect full offline support earlier than Phase 4
- Sync conflict resolution UX needs careful design
- Local data storage adds client complexity
- Testing scenarios multiply (online, offline, partial connectivity, sync conflicts)

### Risks

- Users might attempt financial operations offline and be confused by rejection
- Sync queue data loss on client device
- Conflict resolution may require manual intervention

## Mitigations

- Clear UI indicators of online/offline status and operation availability
- Persistent local storage for sync queue with integrity checks
- Automated testing of sync scenarios with various failure modes
- User confirmation required before syncing financial operations
