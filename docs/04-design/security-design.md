# Security Design — CircleFund

## Overview

CircleFund handles sensitive financial and personal information. This document defines the security architecture and controls.

## Threat Model

### Attack Surface

```text
External Attacker
     │
     ├── Authentication endpoints → Brute force, credential stuffing
     ├── API endpoints → Injection, broken access control
     ├── Frontend → XSS, CSRF, data exposure
     ├── Network → Man-in-the-middle, eavesdropping
     ├── Supply chain → Compromised dependencies
     └── Social engineering → Phishing, credential theft
```

### STRIDE Analysis

| Threat | Mitigation |
|--------|-----------|
| **S**poofing | Strong authentication, MFA support, token rotation |
| **T**ampering | HTTPS, database constraints, validation at all layers |
| **R**epudiation | Audit trail for all financial operations |
| **I**nformation Disclosure | RBAC, resource ownership, encryption at rest and in transit |
| **D**enial of Service | Rate limiting, input validation, request size limits |
| **E**levation of Privilege | RBAC, resource-level authorization, principle of least privilege |

## Authentication

### Identity Provider

CircleFund uses ASP.NET Core Identity for authentication:

- Email/username + password
- Password hashing: PBKDF2 with high iteration count
- Session management via JWT tokens
- Refresh token rotation

### Password Policy

| Rule | Requirement |
|------|-------------|
| Minimum length | 8 characters |
| Complexity | Upper, lower, digit, special character |
| Common password check | Block known compromised passwords |
| Password age | Expire every 90 days (optional) |
| Password history | Remember last 5 passwords |
| Lockout | 5 failed attempts → 15 minute lockout |

### Token Management

```text
Login
  ↓
Access Token (short-lived: 15 minutes)
  +
Refresh Token (longer-lived: 7 days, sliding)
  ↓
API Requests (Access Token in Authorization header)
  ↓
Token Refresh (when expired)
  ↓
Re-authentication (when refresh expired)
```

## Authorization

### Authorization Model

```text
Authentication (who are you?)
     ↓
User (identity)
     ↓
Group Membership (what groups?)
     ↓
Role (what role in group?)
     ↓
Permission (what actions?)
     ↓
Resource Ownership (do you own it?)
     ↓
Action (what are you doing?)
     ↓
State (is resource in valid state?)
     ↓
Authorized / Denied
```

### Roles

| Role | Description | Permissions |
|------|-------------|------------|
| System Administrator | Platform admin | All system-wide operations |
| Group Owner | Group administrator | All group management operations |
| Chủ Hụi (Circle Organizer) | Circle manager | Financial operations, member management |
| Treasurer | Financial manager | Financial viewing, contribution recording |
| Secretary | Admin manager | Administrative tasks, records |
| Moderator | Content moderator | Content moderation |
| Member (Hụi Viên) | Participant | View own data, contributions |
| Viewer | Read-only | View accessible data only |

### Authorization Enforcement

Authorization is enforced at multiple levels:

1. **API level:** Middleware validates tokens and basic permissions
2. **Application level:** Handlers check resource access and permissions
3. **Domain level:** Domain rules validate business-level authorization
4. **Database level:** Row-level security where supported

### Resource Ownership

Every data-access check considers:

- Can the user access this circle? (membership check)
- Can this user perform this action on this resource? (role/permission check)
- Is the resource in a valid state for this action? (state check)

## Data Protection

### Encryption

| Layer | Method |
|-------|--------|
| In transit | TLS 1.3 (HTTPS enforced in production) |
| At rest | PostgreSQL encryption at rest |
| Sensitive fields | Application-level encryption where required |
| Backups | Encrypted at rest |

### Secrets Management

- Secrets stored in environment variables or secret management systems
- Never committed to version control
- `.gitignore` includes config files with secrets
- CI/CD injects secrets at deployment time

## Input Validation

### Validation Layers

```text
Frontend validation (UX improvement, NOT security)
     ↓
API request validation (FluentValidation or similar)
     ↓
Application validation (business rule checks)
     ↓
Domain invariant validation
     ↓
Database constraints (last line of defense)
```

### Validation Rules

| Input Type | Validation |
|------------|-----------|
| Text fields | Maximum length, no control characters, sanitized |
| Numbers | Type check, range check, precision check (financial) |
| Dates | Valid date, not in future where applicable, not before epoch |
| IDs | UUID format check, existence check |
| File uploads | Type whitelist, size limit, virus scan (progressive) |
| JSON payloads | Schema validation, depth limit, size limit |

## XSS Prevention

- Vue 3 template auto-escapes by default
- No `v-html` with user-supplied content
- Content Security Policy (CSP) headers
- HTTPOnly and Secure flags on cookies
- Strict MIME type checking

## CSRF Protection

- Anti-forgery tokens for state-changing operations
- SameSite cookie attribute
- Custom header requirement for API requests
- Origin/Referer header validation

## SQL Injection Prevention

- Entity Framework Core uses parameterized queries by default
- No raw SQL with string interpolation
- All database access through EF Core
- Input validation and sanitization at application layer

## Rate Limiting

| Endpoint | Limit | Window |
|----------|-------|--------|
| Login | 10 requests | Per minute per user/IP |
| Registration | 5 requests | Per minute per IP |
| Password reset | 3 requests | Per hour per user |
| Financial mutations | 5 requests | Per second per user |
| General API | 1000 requests | Per hour per user |

## Audit Logging for Security

Security-relevant events are audited:

| Event | Data Captured |
|-------|--------------|
| Login success | User, timestamp, IP, user agent |
| Login failure | User (if known), timestamp, IP, reason |
| Logout | User, timestamp |
| Token refresh | User, timestamp |
| Permission change | Actor, target, before/after, timestamp |
| Circle configuration change | Actor, circle, before/after, timestamp |
| Financial operation | Actor, operation, amount, timestamp |
| Failed authorization | User, resource, action, timestamp |

## Security Checklist

### Development

- [ ] OWASP Top 10 awareness
- [ ] Dependency scanning (npm, NuGet)
- [ ] Static analysis enabled
- [ ] No secrets in code or logs
- [ ] Input validation on all user inputs
- [ ] Parameterized queries only
- [ ] Output encoding where needed
- [ ] Security headers configured
- [ ] HTTPS enforced in production
- [ ] Authentication on all API endpoints (except explicitly public)

### Deployment

- [ ] Firewall rules configured
- [ ] HTTPS certificate valid and auto-renewing
- [ ] Database not publicly accessible
- [ ] Secrets managed properly
- [ ] Logging configured with no PII in logs (except audit trail)
- [ ] Backup encryption verified
- [ ] Access controls tested
- [ ] Security scanning scheduled

### Operations

- [ ] Security patches applied promptly
- [ ] Dependency updates reviewed
- [ ] Incident response plan (see `docs/08-operations/incident-response.md`)
- [ ] Regular security reviews
- [ ] Penetration testing (periodic)
- [ ] Audit log review process
