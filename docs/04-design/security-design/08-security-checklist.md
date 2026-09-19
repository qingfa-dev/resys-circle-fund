# Security Design — Checklist

## Development
- [ ] OWASP Top 10 awareness; dependency scanning; static analysis
- [ ] No secrets in code/logs; input validation on all inputs
- [ ] Parameterized queries only; output encoding; security headers
- [ ] HTTPS enforced; auth on all endpoints except public

## Deployment
- [ ] Firewall; valid TLS; DB not public; secrets managed
- [ ] Logging with no PII (except audit); backup encryption; access-control tests

## Operations
- [ ] Security patches applied; dependency updates reviewed
- [ ] Incident response plan (`docs/08-operations/incident-response/`)
- [ ] Regular security reviews, periodic penetration testing, audit-log review