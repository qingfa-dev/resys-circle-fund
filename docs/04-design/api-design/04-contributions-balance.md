# API Design — Contributions & Balance

## Contributions

| Method | Endpoint | Notes |
| --- | --- | --- |
| POST | `/circles/{circleId}/rounds/{roundId}/contributions` | Idempotency-Key required |
| GET | `/circles/{circleId}/rounds/{roundId}/contributions` | |
| GET | `/contributions/{id}` | |
| POST | `/contributions/{id}/reverse` | |

## Balance

| Method | Endpoint |
| --- | --- |
| GET | `/circles/{circleId}/members/{memberId}/balance` |
| GET | `/circles/{circleId}/rounds/{roundId}/balance` |
| GET | `/circles/{circleId}/balance` |

## Example: Record Contribution

```http
POST /api/v1/circles/{circleId}/rounds/{roundId}/contributions
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000

{ "memberId": "...", "shareId": "...", "amount": 1000000.00,
  "paymentDate": "2026-09-15", "paymentMethod": "cash", "reference": "CHQ001", "note": "..." }
```

Offline contributions are captured locally with a `localId`, replay via `/sync/batch`, and are marked pending-sync (excluded from authoritative totals) until confirmed.