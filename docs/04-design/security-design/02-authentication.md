# Security Design — Authentication

## Identity Provider (ASP.NET Core Identity)

| Setting | Value |
| --- | --- |
| Password hashing | PBKDF2 (Identity default, >=200k iterations) |
| Token | JWT, HS256, 15-min lifetime |
| Refresh token | opaque, 7-day sliding, rotated on refresh |
| Lockout | 5 attempts → 15 min |
| Password min | 8 chars, upper+lower+digit+special |
| Password history | 5 |

## JWT Claims

```json
{ "sub": "<userId>", "email": "...", "name": "...",
  "role": "CircleOrganizer", "iat": ..., "exp": ...,
  "jti": "<tokenId>" }
```

## Token Management Flow

```text
Login → { accessToken(15m), refreshToken(7d) }
API  → Authorization: Bearer <accessToken>
Expired access → POST /auth/refresh { refreshToken } → new pair
Refresh expired → re-authenticate
```

## Offline Authentication

- On first login, cache a credential verifier (e.g., salted hash) locally.
- Offline unlock verifies against the cache → read-only session (FR-I1-040).
- Cached credential is cleared on logout and on remote session invalidation.