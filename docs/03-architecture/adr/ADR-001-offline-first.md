# ADR-001: Offline-First Approach

## Status

Accepted

## Context

CircleFund users (Circle Organizers, Circle Members) frequently operate in connectivity-poor contexts (village visits, market stalls). The original draft deferred offline support to a late "Advanced Platform" iteration, which would have forced a costly retrofit of every feature. Financial operations add unique challenges for offline mode:

- Duplicate transactions when connectivity resumes
- Retry handling for failed operations
- Conflicting changes between local and server state
- Idempotency of financial operations
- Synchronization ordering
- Conflict resolution between offline and online edits

## Decision

CircleFund adopts **offline-first as its day-1 foundation**:

1. **Iteration 1 builds the local store and operation queue** (`FR-I1-041` to `FR-I1-045`), with a sync engine and conflict detection, before or alongside the ROSCA aggregate. Every writing slice is designed against the offline flow from the start.

2. **The server remains the authoritative source** for all financial records; the client is a synchronization client, never authoritative.

3. **Financial mutations inherit the offline queue** in Iteration 2 (`FR-I2-047` to `FR-I2-049`), with conflict escalation (manual reconciliation) rather than auto-merge.

### Offline Scope (Day-1, Iterations 1–2)

**Available offline (write):**

- Contribution recording
- Payout Draw, Bidding (Iteration 2), and simple data-entry operations

**Available offline (read-only cache):**

- Circle summaries and current balances
- Recent contribution history
- Upcoming round schedules
- Member lists

**Available offline (with manual resolution):**

- Conflicting edits (financial and non-financial) — surfaced, never auto-merged

**Not available offline:**

- Complex financial calculations requiring authoritative server state
- Configuration changes
- Integration-dependent actions (Iteration 3)

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

- Users in areas with unreliable connectivity can perform core operations from day one
- Offline-first foundations are built into Iteration 1, avoiding a costly retrofit
- Server-authoritative model prevents financial inconsistencies
- Idempotency at the API layer supports safe retry during sync

### Negative

- Sync conflict-resolution UX needs careful design
- Local data storage adds client complexity
- Testing scenarios multiply (online, offline, partial connectivity, sync conflicts)
- Every Iteration 1–2 slice must be designed against the queue, which is more upfront work

### Risks

- Sync queue data loss on client device
- Conflict resolution may require manual intervention for financial mutations
- Incorrectly treating a pending-sync record as authoritative
- Local-ID collisions with server IDs

## Mitigations

- Clear UI indicators of online/offline status and operation availability
- Persistent local storage for sync queue with integrity checks
- Automated testing of sync scenarios with various failure modes
- User confirmation required before syncing financial operations
