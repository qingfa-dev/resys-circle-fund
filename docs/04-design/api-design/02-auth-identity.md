# API Design — Auth & Identity

## Authentication
Bearer token (JWT). Public endpoints: register, login, refresh, health. Financial mutations additionally require `Idempotency-Key`.

## Endpoints

| Method | Endpoint | Notes |
| --- | --- | --- |
| POST | `/auth/register` | public |
| POST | `/auth/login` | public |
| POST | `/auth/refresh` | public |
| POST | `/auth/logout` | |
| POST | `/auth/forgot-password` | public |
| POST | `/auth/reset-password` | public |
| GET | `/users/me` | |
| PUT | `/users/me/profile` | |
| POST | `/auth/external/{provider}` | I3 |
| DELETE | `/users/me/external-identities/{id}` | I3 |