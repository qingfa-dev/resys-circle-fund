# Security Design — Input Validation & Injection Prevention

## Validation Layers

```text
Frontend validation (UX only) → API validation → Application validation → Domain invariants → DB constraints
```

## Rules

| Input | Validation |
| --- | --- |
| Text | max length, no control chars, sanitized |
| Numbers | type, range, precision (financial) |
| Dates | valid, not future where applicable |
| IDs | UUID format + existence |
| File uploads | type whitelist, size limit, scan |
| JSON | schema validation, depth/size limits |

## Injection Prevention

- Vue 3 template auto-escapes; no `v-html` with user content; CSP headers.
- EF Core parameterized queries; no raw SQL with string interpolation.
- Anti-forgery tokens, SameSite cookies, custom headers, Origin validation (CSRF).