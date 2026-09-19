# Security Design — Threat Model

**Source:** `docs/04-design/security-design.md` (index)

CircleFund handles sensitive financial and personal information.

## Attack Surface

```text
External Attacker
  ├── Auth endpoints → brute force, credential stuffing
  ├── API endpoints → injection, broken access control
  ├── Frontend → XSS, CSRF, data exposure
  ├── Network → MITM, eavesdropping
  ├── Supply chain → compromised dependencies
  └── Social engineering → phishing
```

## STRIDE

| Threat | Mitigation |
| --- | --- |
| Spoofing | Strong auth, MFA support, token rotation |
| Tampering | HTTPS, DB constraints, layered validation |
| Repudiation | Audit trail for all financial operations |
| Information disclosure | RBAC, resource ownership, encryption at rest/in transit |
| DoS | Rate limiting, input validation, request-size limits |
| Elevation of privilege | RBAC, resource-level authorization, least privilege |