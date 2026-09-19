# Security Design — Rate Limiting & Audit Logging

## Rate Limiting

| Endpoint | Limit |
| --- | --- |
| Login | 10 req/min/user or IP |
| Registration | 5 req/min/IP |
| Password reset | 3 req/hour/user |
| Financial mutations | 5 req/s/user |
| General API | 1000 req/hour/user |

## Security Audit Logging

| Event | Captured |
| --- | --- |
| Login success/failure | user, timestamp, IP, agent, reason |
| Logout / Token refresh | user, timestamp |
| Permission change | actor, target, before/after |
| Circle config change | actor, circle, before/after |
| Financial operation | actor, operation, amount |
| Failed authorization | user, resource, action |