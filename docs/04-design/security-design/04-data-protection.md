# Security Design — Data Protection

## Encryption

| Layer | Method |
| --- | --- |
| In transit | TLS 1.3 (HTTPS enforced in production) |
| At rest | PostgreSQL encryption at rest |
| Sensitive fields | Application-level encryption where required |
| Backups | Encrypted at rest |

## Secrets Management

- Secrets via environment variables or a secret manager; never committed.
- `.gitignore` excludes config files with secrets.
- CI/CD injects secrets at deployment time.