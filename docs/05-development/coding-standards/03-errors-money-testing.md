# Coding Standards — Errors, Money, Dependencies, Testing, Git

**Index:** `docs/05-development/coding-standards.md`

## Error Handling
Backend: global middleware; typed domain exceptions; 400/404/403/409 (incl. SYNC_CONFLICT)/422/500. Frontend: centralized API mapping; offline indicator; conflict surfacing.

## Money Handling
Fixed-precision `decimal` only; rounding half-up at final step (BR-FIN-007).

## Dependency Rules
`Presentation → Application → Domain`; `→ Infrastructure → Persistence`; Tests → all. Domain has no project dependencies. Group imports: framework, third-party, project (alphabetical).

## Testing
One behavior per test; arrange-act-assert; `Method_Scenario_ExpectedResult`. Domain rules, calculations, offline/sync, idempotency, authorization require tests.

## Git
Conventional commits: `feat(scope):`, `fix(scope):`, `test(scope):`, `docs(scope):`, `refactor(scope):`, `chore(scope):`. See `git-workflow.md`.