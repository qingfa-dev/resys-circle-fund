# ADR-004: Idempotency Strategy

## Status

Accepted

## Context

CircleFund processes financial operations that must not be duplicated. Network failures, user impatience (double-clicking), and automatic retries can all lead to duplicate operations. A single contribution being recorded twice, a payout being processed twice, or a bid being submitted twice are all unacceptable outcomes in a financial system.

### Considered Approaches

1. **No idempotency:** Rely on unique database constraints to prevent duplicates. Simple but doesn't handle all cases (e.g., user clicks "submit" twice before the first request completes).

2. **Application-level deduplication:** Check for existing operation before processing. Better but has race conditions in concurrent scenarios.

3. **Idempotency keys:** Client generates a unique key per operation. Server stores key + result. Duplicate requests return stored result. Most robust, industry-standard approach.

## Decision

CircleFund uses **idempotency keys** for all financial mutation endpoints.

### How It Works

1. **Client generates a UUIDv4** as the idempotency key for each financial operation
2. **Key is included in request header:** `Idempotency-Key: <uuid>`
3. **Server checks key store:**
   - Key found → return stored response (HTTP 200, same response as original)
   - Key not found → process request normally, store key + response
4. **Key retention:** Keys are stored for 24 hours (configurable)
5. **Key scope:** Per user, per circle — keys from different users/circles don't conflict

### Endpoints Requiring Idempotency

- POST /api/circles/{circleId}/rounds/{roundId}/contributions
- POST /api/circles/{circleId}/rounds/{roundId}/payouts
- POST /api/circles/{circleId}/rounds/{roundId}/bids
- POST /api/circles/{circleId}/rounds/{roundId}/reversals
- Any other financial mutation endpoint

### Endpoints NOT Requiring Idempotency

- GET requests (naturally idempotent)
- Non-financial mutations (member management, profile updates)
- Query operations

### Key Generation Guidelines

- **Frontend:** Generate UUIDv4 when user initiates a financial action
- **Same session, same operation:** Use same key if user retries before seeing response
- **New attempt:** Generate new key for each new attempt
- **Key storage:** Client stores key in local state until operation confirmed

### Response Caching

When a key is found:

```text
HTTP 200 OK
X-Idempotency: cached
Content-Type: application/json

{
    "data": { ... original response ... }
}
```

When a key is new and processing succeeds:

```text
HTTP 200 OK
X-Idempotency: processed
Content-Type: application/json

{ "data": { ... } }
```

When a key is found but the original request failed:

```text
HTTP 409 Conflict
X-Idempotency: failed
Content-Type: application/json

{
    "error": {
        "code": "IDEMPOTENCY_KEY_FAILED",
        "message": "Original operation failed"
    }
}
```

### Server-Side Implementation

```text
1. Extract Idempotency-Key from header
2. Validate key format (UUIDv4)
3. Check key store (database table or Redis)
4. If found:
   a. Return stored response with appropriate status code
5. If not found:
   a. Begin database transaction
   b. Process financial operation (with unique constraint checks)
   c. Store key + response hash in key store
   d. Commit transaction
   e. Return response
6. On any error during processing:
   a. Store key + error in key store (marked as failed)
   b. Return error response
```

### Database Schema

```text
IdempotencyKeys
├── Key (UUID, PK) — the idempotency key
├── UserId (UUID, FK) — user who made the request
├── CircleId (UUID, FK) — circle context
├── Endpoint (text) — API endpoint
├── Method (text) — HTTP method
├── RequestBodyHash (text) — hash of request body
├── ResponseStatus (integer) — HTTP status code
├── ResponseBody (jsonb) — serialized response
├── ProcessedAt (timestamptz) — when processed
└── ExpiresAt (timestamptz) — when key expires (24h)
```

## Consequences

### Positive

- Duplicate financial operations are impossible, even with network failures and retries
- User experience is safe — users can retry without fear
- System is resilient to transient failures
- Audit trail of all operations through idempotency records

### Negative

- Client must generate and manage idempotency keys
- Server must maintain key store (additional database/Redis)
- Key store requires cleanup/expiry (24h default)
- Failed operations are cached for the retention period (prevents immediate retry)
- Additional storage and processing overhead per request

### Risks

- Key store becomes a single point of failure (mitigated by Redis persistence and database backing)
- Client crashes after generating key but before receiving response (user must generate new key, server handles correctly)
- Keys may leak across sessions (mitigated by key scoping per user/circle)

## Mitigations

- Redis for key store with persistence to database
- Background job to clean expired keys
- Clear error messages when a key is found but original operation failed
- Client-side key recovery: if unsure, generate new key (server handles correctly either way due to request body hash)
- API documentation clearly specifies idempotency requirements
- Integration tests cover concurrent duplicate scenarios
