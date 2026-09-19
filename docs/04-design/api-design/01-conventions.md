# API Design — Conventions

**Source:** `docs/04-design/api-design.md` (index)

## Base URL & Versioning
`https://circlefund.example.com/api/v1` — URL-path versioning; OpenAPI/Swagger as the machine-readable contract (NFR-025).

## Response Conventions

```json
{ "data": { } }                                                    // success
{ "data": [ ], "pagination": { "total": 0, "page": 1, "pageSize": 20, "totalPages": 0 } } // list
{ "error": { "code": "VALIDATION_ERROR", "message": "...", "details": [ { "field": "amount", "message": "..." } ] } }
```

## Error Codes

VALIDATION_ERROR (400), AUTHENTICATION_REQUIRED (401), TOKEN_EXPIRED (401), FORBIDDEN (403), NOT_FOUND (404), CONFLICT (409), IDENTITY_KEY_EXISTS (409), INVALID_OPERATION (422), SYNC_CONFLICT (409), RATE_LIMITED (429), INTERNAL_ERROR (500).

## Endpoint Patterns

| Action | Method | Pattern |
| --- | --- | --- |
| Create | POST | `/api/{resource}` |
| Get | GET | `/api/{resource}/{id}` |
| List | GET | `/api/{resource}?page=&pageSize=&sortBy=&sortOrder=&filter[]=&search=` |
| Update | PUT/PATCH | `/api/{resource}/{id}` |
| Delete | DELETE | `/api/{resource}/{id}` |

## Validation / Pagination / Rate Limiting

Amounts `> 0` with ≤ 2 decimals; dates ISO 8601; IDs UUID; strings trimmed and length-limited. `pageSize` capped at 100. Rate limits: auth 10/min/user; financial mutations 5/s/user; list endpoints 100/min/user.