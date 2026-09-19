# API Design — Payout Draw, Bidding, Rotation

## Payout Draw

```http
POST /api/v1/circles/{circleId}/rounds/{roundId}/payouts
Idempotency-Key: <uuid>
{ "recipientId": "...", "payoutDate": "...", "payoutMethod": "cash" }
```

```json
{ "data": { "id": "...", "grossAmount": 5000000, "interestAmount": 0,
  "discountAmount": 200000, "netAmount": 4800000, "status": "Completed" } }
```

`POST /payouts/{id}/reverse` → compensating reversal entry (no delete).

## Bidding

```http
POST /api/v1/circles/{circleId}/rounds/{roundId}/bids
Idempotency-Key: <uuid>
{ "memberId": "...", "amount": 250000 }
POST /api/v1/circles/{circleId}/rounds/{roundId}/bids/determine-winner
```

## Rotation / Lottery

```http
POST /api/v1/circles/{circleId}/rounds/{roundId}/rotation/select
POST /api/v1/circles/{circleId}/rounds/{roundId}/lottery
```

All financial mutation endpoints require `Idempotency-Key`; conflicts return `409 SYNC_CONFLICT` (financial → manual reconciliation).