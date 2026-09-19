# API Design — Circles, Rounds, Members, Shares

## Circles / Rounds

| Method | Endpoint |
| --- | --- |
| POST / GET | `/circles` |
| GET / PUT | `/circles/{circleId}` |
| PATCH | `/circles/{circleId}/status` |
| GET | `/circles/{circleId}/summary` |
| POST / GET | `/circles/{circleId}/rounds` |
| GET / PATCH | `/circles/{circleId}/rounds/{roundId}` |

## Members / Shares

| Method | Endpoint |
| --- | --- |
| POST / GET | `/circles/{circleId}/members` |
| GET / PATCH / DELETE | `/circles/{circleId}/members/{memberId}` |
| POST / GET | `/circles/{circleId}/members/{memberId}/shares` |
| POST | `/circles/{circleId}/shares/transfer` |