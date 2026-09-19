# Coding Standards — CircleFund

## Language Standards

### C# (.NET Backend)

- C# 12+ language version
- Nullable reference types enabled (warnings as errors)
- Top-level statements not used in library projects
- Async/await pattern throughout (no blocking calls)
- `async Task<T>` for async methods, `async void` only for event handlers
- `ConfigureAwait(false)` in library code
- Expression-bodied members where appropriate
- Pattern matching where it improves readability
- Records for DTOs and value objects
- `global using` for common namespaces

### TypeScript (Frontend)

- TypeScript 5+ strict mode enabled
- No `any` type — use `unknown` with proper guards
- Strict null checks
- Interfaces over types (when possible)
- Functional patterns preferred (immutability, pure functions)
- Destructuring and spread over mutation
- Named imports (no barrel files unless for index exports)
- Enums or discriminated unions over string literals

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| C# Class | PascalCase | `RecordContributionCommand` |
| C# Method | PascalCase | `RecordContribution` |
| C# Variable | camelCase | `circleId` |
| C# Interface | I-prefix | `ICircleRepository` |
| C# Enum | PascalCase | `PeriodStatus` |
| C# Enum Value | PascalCase | `PeriodStatus.Open` |
| TypeScript Interface | PascalCase | `CircleDetail` |
| TypeScript Type | PascalCase | `CircleSummary` |
| TypeScript Variable | camelCase | `circleId` |
| TypeScript Function | camelCase | `getCircleById` |
| Vue Component | PascalCase (file) | `CircleList.vue` |
| Vue Component | kebab-case (usage) | `<circle-list>` |
| Pinia Store | camelCase | `useCircleStore` |
| API Route | kebab-case | `/api/circles/create` |
| Database Table | snake_case | `circles` |
| Database Column | snake_case | `circle_id` |

## Project Structure

### Backend (Vertical Slice)

```text
src/
├── CircleFund.Api/
│   ├── Controllers/ (thin controllers, dispatch to handlers)
│   ├── Middleware/ (error handling, auth, logging)
│   └── Extensions/ (DI registration, etc.)
│
├── CircleFund.Application/
│   ├── Features/
│   │   ├── Hoi/
│   │   │   ├── CreateHoi/
│   │   │   │   ├── CreateHoiCommand.cs
│   │   │   │   ├── CreateHoiCommandHandler.cs
│   │   │   │   ├── CreateHoiValidator.cs
│   │   │   │   ├── CreateHoiResponse.cs
│   │   │   │   └── CreateHoiTests.cs
│   │   │   ├── GetHoi/
│   │   │   └── ...
│   │   ├── Contributions/
│   │   ├── Bidding/
│   │   └── ...
│   ├── Common/
│   │   ├── Interfaces/
│   │   ├── Models/
│   │   ├── Validators/
│   │   └── Behaviors/ (pipeline behaviors)
│   └── DependencyInjection.cs
│
├── CircleFund.Domain/
│   ├── Entities/
│   ├── ValueObjects/
│   ├── Enums/
│   ├── Events/
│   ├── Exceptions/
│   ├── Interfaces/
│   └── Rules/
│
├── CircleFund.Infrastructure/
│   ├── Persistence/
│   │   ├── DbContext/
│   │   ├── Configurations/ (EF Core fluent API)
│   │   ├── Migrations/
│   │   ├── Repositories/
│   │   └── Interceptors/
│   ├── Authentication/
│   ├── Authorization/
│   ├── Caching/
│   ├── ExternalServices/
│   └── DependencyInjection.cs
│
└── CircleFund.Tests/
    ├── UnitTests/
    ├── IntegrationTests/
    ├── ApiTests/
    └── Common/
```

### Frontend

```text
src/
├── components/
│   ├── ui/ (reusable UI components)
│   ├── financial/ (financial-specific components)
│   └── shared/ (shared across features)
├── composables/ (Vue composables)
├── layouts/
├── pages/ (route-level pages)
│   ├── dashboard/
│   ├── circles/
│   │   ├── [circleId]/
│   │   │   ├── index.vue
│   │   │   ├── members.vue
│   │   │   ├── periods.vue
│   │   │   └── ledger.vue
│   │   └── new.vue
│   └── ...
├── stores/ (Pinia stores)
├── services/ (API service layer)
├── types/ (TypeScript types)
├── utils/
├── assets/
├── styles/
├── App.vue
└── main.ts
```

## Code Style

### C#

- `.editorconfig` enforces style rules (see root `.editorconfig`)
- Roslyn analyzers enabled
- `var` used when type is obvious from right side
- String interpolation preferred over concatenation
- Null-coalescing and null-conditional operators where appropriate
- `ExceptionDispatchInfo.Capture` for exception re-throwing
- Dependency Injection for all services
- `IAsyncEnumerable<T>` for streaming data

### TypeScript / Vue

- ESLint with Vue and TypeScript plugins
- Prettier for formatting
- Vue 3 Composition API
- `<script setup>` syntax
- Typed props and emits
- `setup()` only for complex scenarios
- Computed properties for derived state
- Watchers with deep option where needed
- No side effects in templates

### Formatting

- 4 spaces indentation (no tabs)
- Trailing commas in multi-line (JavaScript, TypeScript, C# collections)
- Final newline at end of file
- No whitespace before `(` in function calls (C#) or `(` in JavaScript function declarations

## Error Handling

### Backend

- Global exception handler middleware
- Specific exception types for domain errors
- Never catch `System.Exception` broadly without re-throwing
- Validation errors return 400 with field details
- Not found errors return 404
- Authorization errors return 403
- Concurrency errors return 409
- Internal errors return 500 with correlation ID (no details leaked)

### Frontend

- API service layer handles HTTP errors centrally
- Errors mapped to user-friendly messages
- Network errors show offline indicator
- Form errors show field-specific messages
- Unexpected errors show generic error page with retry option
- Error logging service for reporting

## Comments

- Code should be self-documenting through clear naming
- Comments explain **why**, not **what**
- XML documentation for public APIs only
- No commented-out code in committed changes
- No TODO comments without an associated issue/PR link
- Architectural decisions documented in ADRs, not in code comments

## File Organization

- One class/interface per file (C#)
- File name matches class name exactly
- Feature-related files co-located in vertical slices
- Shared/generic files in shared directories
- No circular dependencies between projects

## Dependency Rules

### C# Project References

```text
Presentation → Application → Domain
                      ↓
                 Infrastructure → Persistence
                      ↓
                 Tests → all layers
```

- Presentation (API) depends on Application, Infrastructure
- Application depends on Domain, Infrastructure
- Domain has no project dependencies
- Infrastructure depends on Domain, Presentation (for DI registration)
- Tests depend on all layers

### Import Rules

- Group imports: Framework, Third-party, Project (alphabetical within group)
- No wildcard imports
- Remove unused imports

## Git Workflow

See `docs/05-development/git-workflow.md` for detailed branching strategy.

### Commit Message Format

```text
<type>(<scope>): <subject>

<body> (optional, explain what and why)

<footer> (optional, issue references)
```

Types:

| Type | Description |
|------|-------------|
| feat | New feature |
| fix | Bug fix |
| test | Adding or updating tests |
| docs | Documentation changes |
| refactor | Code restructuring without behavior change |
| chore | Build, tooling, dependency updates |
| ci | CI/CD pipeline changes |
| style | Formatting (no logic change) |
| perf | Performance optimization |

Examples:

```text
feat(contribution): record member contribution
test(contribution): add contribution handler tests
fix(balance): prevent duplicate balance update
refactor(ledger): extract transaction calculation
docs(api): update contribution endpoint
```

## Testing Standards

See `docs/06-verification/test-strategy.md` for testing guidelines.

### Unit Tests

- Test one behavior per test
- Clear arrange-act-assert pattern
- Descriptive test names: `MethodName_Scenario_ExpectedResult`
- No test interdependence
- Fast execution (no I/O, no network)
- Domain rules must have unit tests

### Integration Tests

- Test API endpoints with in-memory server (WebApplicationFactory)
- Use test database (isolated per test run)
- Verify database state changes
- Test authorization rules

### API Contract Tests

- Verify response schemas
- Verify error schemas
- Verify status codes
- Verify validation behavior
