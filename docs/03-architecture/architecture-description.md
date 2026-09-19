# Architecture Description — CircleFund

## 1. System Overview

CircleFund is a web application designed as a progressive web application (PWA) with a REST API backend and a relational database.

```text
┌─────────────────────────────────┐
│          CircleFund Web         │
│        Vue + TypeScript         │
│              PWA                │
└────────────────┬────────────────┘
                  │
                  │ REST API
                  ▼
┌─────────────────────────────────┐
│       CircleFund API            │
│        ASP.NET Core             │
├─────────────────────────────────┤
│          Application            │
│             Domain              │
│        Authorization            │
└────────────────┬────────────────┘
                  │
                  ▼
┌─────────────────────────────────┐
│            EF Core              │
└────────────────┬────────────────┘
                  │
                  ▼
┌─────────────────────────────────┐
│           PostgreSQL            │
└─────────────────────────────────┘
```

## 2. Architecture Style

CircleFund follows a **domain-oriented, vertical-slice architecture** with CQRS-inspired patterns:

- **Frontend:** Vue 3 + TypeScript, component-based, state managed via Pinia
- **Backend:** ASP.NET Core Web API with vertical slice organization
- **Domain:** Domain-driven design principles, business rules in domain/application layer
- **Persistence:** Entity Framework Core with PostgreSQL
- **Communication:** REST API between frontend and backend

## 3. Vertical Slice Organization

Features are organized as vertical slices rather than horizontal layers:

```text
Features/
│
├── Hoi/
│   ├── CreateHoi/
│   ├── GetHoi/
│   ├── UpdateHoi/
│   ├── CloseHoi/
│   └── ...
│
├── Contributions/
│   ├── RecordContribution/
│   ├── GetContribution/
│   └── ...
│
├── Bidding/
│   ├── RecordBid/
│   ├── DetermineWinner/
│   └── ...
│
├── Members/
│   ├── AddMember/
│   ├── RemoveMember/
│   └── ...
│
└── Reports/
```

## 4. Vertical Slice Pattern

Each vertical slice contains:

```text
Endpoint
Request (command/query)
Validator
Command/Query Handler
Response (result/DTO)
Mapping
Tests
```

## 5. Cross-Cutting Concerns

Each request passes through:

```text
Authentication
Authorization
Validation
Idempotency (for mutations)
Logging
Error handling
Audit recording (where required)
```

## 6. Key Architectural Decisions

| Decision | Status | Notes |
|----------|--------|-------|
| Offline-first | See ADR-001 | Progressive, not initial |
| Sync strategy | See ADR-002 | Server-authoritative |
| Financial ledger | See ADR-003 | Append-only, compensating transactions |
| Idempotency | See ADR-004 | Key-based deduplication |
| Money handling | Decimal | Fixed-precision, no floating-point |
| Database | PostgreSQL | Relational with strong constraints |
| Caching | Redis (progressive) | Not in initial release |
| Message bus | Outbox pattern | For reliable event publishing |

## 7. Data Flow

### Typical Financial Operation

```text
Member makes contribution
        │
        ▼
API receives command
        │
        ▼
Validate domain rules
        │
        ▼
Begin database transaction
        │
        ├── Record contribution
        ├── Update balance (read model)
        ├── Record ledger transaction
        ├── Record audit information
        └── Create outbox/event record
        │
        ▼
Commit transaction
        │
        ▼
Publish asynchronous events (from outbox)
        │
        ▼
Notification / reporting updates
```

### User Request Flow

```text
UI
 ↓
Route
 ↓
Page
 ↓
Feature component
 ↓
Form / Table
 ↓
Validation
 ↓
API service
 ↓
State management (Pinia)
 ↓
Error handling
 ↓
HTTP Request
 ↓
API Endpoint
 ↓
Command / Query
 ↓
Domain Logic
 ↓
Persistence
```

## 8. Layer Responsibilities

### Presentation (Frontend)

- User interface rendering and interaction
- Client-side validation
- State management (Pinia stores)
- Routing and navigation
- Offline queue (progressive)

### Application Layer (Backend)

- API endpoints and request handling
- Command/query dispatch
- Input validation
- Authorization enforcement
- Transaction management
- Event publishing

### Domain Layer

- Business rules and invariants
- Domain entities and value objects
- Aggregate boundaries
- Domain events
- Financial calculations

### Infrastructure Layer

- Database access (EF Core)
- External service integration
- Caching
- Background job processing
- File storage
- Notification delivery

## 9. Technology Stack

### Backend

- C# 12+
- ASP.NET Core 8+
- ASP.NET Core Web API
- Entity Framework Core
- PostgreSQL (Npgsql)
- ASP.NET Core Identity
- FluentValidation
- MediatR (optional, for CQRS pattern)

### Frontend

- Vue 3
- TypeScript
- Vue Router
- Pinia
- Progressive Web App (PWA) via Vite PWA plugin

### Testing

- xUnit (unit and integration tests)
- Playwright (end-to-end tests)
- FluentAssertions
- WebApplicationFactory (integration testing)

### Infrastructure

- Docker and Docker Compose
- Git
- GitHub Actions (CI/CD)
- Redis (progressive)
- Object storage (progressive)

## 10. Non-Functional Architecture

### Security

- HTTPS enforced in production
- Authentication via ASP.NET Core Identity
- Role-based and resource-level authorization
- Input validation at all layers
- SQL injection prevention (parameterized queries via EF Core)
- CSRF protection
- Rate limiting on sensitive endpoints

### Performance

- Database indexes for query patterns
- Eager loading for related data where appropriate
- Async I/O throughout
- Pagination for list endpoints
- Background processing for heavy operations

### Reliability

- Database transactions for multi-record operations
- Idempotency keys for financial mutations
- Outbox pattern for event publishing
- Retry logic for background jobs
- Graceful error handling with meaningful messages

### Observability

- Structured logging
- Health check endpoints
- Metrics collection (progressive)
- Distributed tracing (progressive)
- Audit trail for financial operations

## 11. Scalability Considerations

- Horizontal scaling of API instances (stateless)
- Database connection pooling
- Read replicas (progressive)
- Caching for read-heavy queries (progressive)
- Async processing for long-running operations
