# API Design — CircleFund

## Overview

CircleFund exposes a REST API consumed by the Vue 3 frontend. All endpoints are prefixed with `/api`. API versioning uses URL path: `/api/v1/...`.

## Base URL

```text
https://circlefund.example.com/api/v1
```

## Authentication

All endpoints require authentication via Bearer token (JWT), except:

- POST /api/auth/register
- POST /api/auth/login
- POST /api/auth/refresh
- GET /api/health

Authentication flow:

```text
1. POST /api/auth/login with credentials
2. Receive access token and refresh token
3. Include access token in Authorization header for subsequent requests
4. When access token expires, use refresh token to get new one
5. If refresh token expires, re-authenticate
```

## Response Format

### Success

```json
{
    "data": { ... }
}
```

### List Responses

```json
{
    "data": [ ... ],
    "pagination": {
        "total": 100,
        "page": 1,
        "pageSize": 20,
        "totalPages": 5
    }
}
```

### Error

```json
{
    "error": {
        "code": "ERROR_CODE",
        "message": "Human-readable message",
        "details": [
            {
                "field": "fieldName",
                "message": "Field-specific error message"
            }
        ]
    }
}
```

### Error Codes

| Code | HTTP Status | Description |
|------|------------|-------------|
| VALIDATION_ERROR | 400 | Input validation failed |
| AUTHENTICATION_REQUIRED | 401 | No or invalid authentication |
| TOKEN_EXPIRED | 401 | Access token expired |
| FORBIDDEN | 403 | Insufficient permissions |
| NOT_FOUND | 404 | Resource not found |
| CONFLICT | 409 | Resource conflict (e.g., duplicate) |
| IDENTITY_KEY_EXISTS | 409 | Idempotency key already processed |
| INVALID_OPERATION | 422 | Business rule violation |
| RATE_LIMITED | 429 | Too many requests |
| INTERNAL_ERROR | 500 | Unexpected server error |

## Endpoint Patterns

### REST Conventions

| Action | HTTP Method | Endpoint Pattern |
|--------|------------|------------------|
| Create | POST | `/api/{resource}` |
| Get one | GET | `/api/{resource}/{id}` |
| List | GET | `/api/{resource}` |
| Update | PUT | `/api/{resource}/{id}` |
| Partial update | PATCH | `/api/{resource}/{id}` |
| Delete | DELETE | `/api/{resource}/{id}` |

### Pagination

Query parameters:

- `page` — Page number (default: 1)
- `pageSize` — Items per page (default: 20, max: 100)
- `sortBy` — Field to sort by
- `sortOrder` — `asc` or `desc` (default: `asc`)
- `filter[field]` — Filter by field value
- `search` — General search

### Idempotency

Financial mutation endpoints require the `Idempotency-Key` header:

```text
POST /api/v1/circles/{circleId}/periods/{periodId}/contributions
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000
```

## API Endpoints

### Auth

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/register` | Register new account |
| POST | `/api/auth/login` | Authenticate |
| POST | `/api/auth/refresh` | Refresh access token |
| POST | `/api/auth/logout` | Invalidate session |
| POST | `/api/auth/forgot-password` | Request password reset |
| POST | `/api/auth/reset-password` | Reset password with token |
| PUT | `/api/users/me/profile` | Update profile |
| GET | `/api/users/me` | Get current user |

### Circles (Dây Hụi)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles` | Create circle |
| GET | `/api/circles` | List circles |
| GET | `/api/circles/{circleId}` | Get circle details |
| PUT | `/api/circles/{circleId}` | Update circle |
| PATCH | `/api/circles/{circleId}/status` | Change circle status |
| DELETE | `/api/circles/{circleId}` | Archive circle |
| GET | `/api/circles/{circleId}/summary` | Circle summary with balances |

### Members

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles/{circleId}/members` | Add member |
| GET | `/api/circles/{circleId}/members` | List members |
| GET | `/api/circles/{circleId}/members/{memberId}` | Member details |
| PATCH | `/api/circles/{circleId}/members/{memberId}/status` | Change member status |
| DELETE | `/api/circles/{circleId}/members/{memberId}` | Remove member |

### Shares

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles/{circleId}/members/{memberId}/shares` | Assign shares |
| GET | `/api/circles/{circleId}/members/{memberId}/shares` | List shares |
| POST | `/api/circles/{circleId}/shares/transfer` | Transfer share |

### Periods (Kỳ Hụi)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles/{circleId}/periods` | Generate periods |
| GET | `/api/circles/{circleId}/periods` | List periods |
| GET | `/api/circles/{circleId}/periods/{periodId}` | Period details |
| PATCH | `/api/circles/{circleId}/periods/{periodId}/status` | Change period status |
| GET | `/api/circles/{circleId}/periods/{periodId}/schedule` | View schedule |

### Contributions

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles/{circleId}/periods/{periodId}/contributions` | Record contribution |
| GET | `/api/circles/{circleId}/periods/{periodId}/contributions` | List contributions |
| GET | `/api/contributions/{contributionId}` | Contribution details |
| POST | `/api/contributions/{contributionId}/reverse` | Reverse contribution |
| GET | `/api/members/{memberId}/contributions` | Member contributions |

### Balance

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/circles/{circleId}/members/{memberId}/balance` | Member balance |
| GET | `/api/circles/{circleId}/periods/{periodId}/balance` | Period balance |
| GET | `/api/circles/{circleId}/balance` | Circle balance |
| POST | `/api/circles/{circleId}/balance/recalculate` | Force recalculation |

### Payouts (Hốt)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles/{circleId}/periods/{periodId}/payouts` | Record payout |
| GET | `/api/circles/{circleId}/periods/{periodId}/payouts` | List payouts |
| POST | `/api/payouts/{payoutId}/reverse` | Reverse payout |

### Bidding (Đấu Thầu)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/circles/{circleId}/periods/{periodId}/bids` | Place bid |
| GET | `/api/circles/{circleId}/periods/{periodId}/bids` | List bids |
| POST | `/api/circles/{circleId}/periods/{periodId}/bids/determine-winner` | Determine winner |

### Ledger

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/circles/{circleId}/ledger` | List ledger entries |
| GET | `/api/circles/{circleId}/ledger/{entryId}` | Ledger entry details |
| GET | `/api/members/{memberId}/ledger` | Member ledger |
| GET | `/api/circles/{circleId}/members/{memberId}/statement` | Member statement |

### Audit

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/circles/{circleId}/audit` | Circle audit records |
| GET | `/api/audit/{recordId}` | Audit record details |
| GET | `/api/users/{userId}/audit` | User activity |

### Reports

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/circles/{circleId}/reports/summary` | Circle summary report |
| GET | `/api/circles/{circleId}/reports/member-statement` | Member statement |
| GET | `/api/circles/{circleId}/reports/export.csv` | Export CSV |
| GET | `/api/circles/{circleId}/reports/export.xlsx` | Export Excel |

## Request/Response Examples

### Record Contribution

Request:

```json
POST /api/v1/circles/{circleId}/periods/{periodId}/contributions
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000
Content-Type: application/json

{
    "memberId": "aaa-bbb-ccc",
    "shareId": "ddd-eee-fff",
    "amount": 1000000.00,
    "paymentDate": "2026-09-15",
    "paymentMethod": "cash",
    "reference": "CHQ001",
    "note": "Monthly contribution"
}
```

Success Response (200):

```json
{
    "data": {
        "id": "111-222-333",
        "circleId": "...",
        "periodId": "...",
        "memberId": "aaa-bbb-ccc",
        "shareId": "ddd-eee-fff",
        "amount": 1000000.00,
        "status": "Paid",
        "paymentDate": "2026-09-15",
        "recordedBy": "user-uuid",
        "recordedAt": "2026-09-15T10:30:00Z",
        "idempotencyKey": "550e8400-e29b-41d4-a716-446655440000"
    }
}
```

Duplicate Request (200 — cached):

```json
{
    "data": {
        "id": "111-222-333",
        ...
    },
    "xIdempotency": "cached"
}
```

### Error Response (400)

```json
{
    "error": {
        "code": "VALIDATION_ERROR",
        "message": "The request contains invalid data.",
        "details": [
            {
                "field": "amount",
                "message": "Amount must be greater than zero."
            }
        ]
    }
}
```

## Validation Rules

| Field | Rule |
|-------|------|
| Amount | decimal, > 0, max 2 decimal places |
| Date | valid date format (ISO 8601) |
| IDs | valid UUID format |
| Strings | trimmed, length limits per field |
| Payment method | must be in configured list |
| Circle/Period/Member IDs | must exist and be accessible |

## Rate Limiting

| Endpoint | Limit |
|----------|-------|
| Auth endpoints | 10 requests per minute per user |
| Financial mutations | 5 requests per second per user |
| List endpoints | 100 requests per minute per user |
| General | 1000 requests per hour per user |

## Versioning

- URL path versioning (`/api/v1/...`)
- Breaking changes increment the version number
- Old versions supported for at least one release cycle after a new version is introduced
- Deprecation notices included in response headers
