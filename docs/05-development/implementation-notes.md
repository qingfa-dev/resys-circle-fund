# Implementation Notes — CircleFund

## Overview

This document captures practical implementation notes, decisions, and patterns that don't fit in other documentation but are important for day-to-day development.

## Key Implementation Patterns

### Financial Operation Pattern

Every financial mutation follows this pattern:

```csharp
public async Task<Result> Handle(RecordContributionCommand request, CancellationToken ct)
{
    // 1. Idempotency check
    var idempotencyKey = request.IdempotencyKey;
    var existing = await _idempotencyStore.GetAsync(idempotencyKey, ct);
    if (existing != null) return existing;

    // 2. Validation (domain rules)
    var validationResult = await _validator.ValidateAsync(request, ct);
    if (!validationResult.IsValid) return Result.ValidationFailed(validationResult.Errors);

    // 3. Domain logic
    var contribution = Contribution.Create(
        request.CircleId, request.PeriodId, request.MemberId, request.ShareId,
        request.Amount, request.PaymentDate, request.PaymentMethod
    );

    // 4. Transaction (all-or-nothing)
    await using var transaction = await _dbContext.Database.BeginTransactionAsync(ct);
    try
    {
        // 4a. Persist business entity
        _dbContext.Contributions.Add(contribution);

        // 4b. Update balance (read model)
        await UpdateBalanceAsync(contribution, ct);

        // 4c. Create ledger entry
        var ledgerEntry = LedgerEntry.FromContribution(contribution);
        _dbContext.LedgerEntries.Add(ledgerEntry);

        // 4d. Create audit record
        var auditRecord = AuditRecord.ForContribution(contribution, "BeforeState", "AfterState");
        _dbContext.AuditRecords.Add(auditRecord);

        // 4e. Create outbox event (for async processing)
        var outboxEvent = OutboxEvent.From(contribution, "ContributionRecorded");
        _dbContext.OutboxEvents.Add(outboxEvent);

        await _dbContext.SaveChangesAsync(ct);
        await transaction.CommitAsync(ct);

        // 5. Store idempotency key
        await _idempotencyStore.StoreAsync(idempotencyKey, Result.Success(contribution), ct);

        return Result.Success(contribution);
    }
    catch
    {
        await transaction.RollbackAsync(ct);
        await _idempotencyStore.StoreFailedAsync(idempotencyKey, ct);
        throw;
    }
}
```

### Vertical Slice Command Handler Pattern

```text
[Feature Folder]
├── Command (input)
│   └── [Action]Command.cs — implements IRequest<T>
├── Query (input)
│   └── [Action]Query.cs — implements IRequest<T>
├── Validator
│   └── [Action]Validator.cs — inherits AbstractValidator<T>
├── Handler
│   └── [Action]Handler.cs — implements IRequestHandler
├── Response / Result
│   └── [Action]Response.cs — DTO for result
├── Mapping Profile
│   └── [Feature]Profile.cs — AutoMapper/Mapper profiles
└── Tests
    └── [Action]Tests.cs — unit/integration tests
```

### Validation Pattern

```csharp
public class RecordContributionValidator : AbstractValidator<RecordContributionCommand>
{
    public RecordContributionValidator()
    {
        RuleFor(x => x.CircleId).NotEmpty();
        RuleFor(x => x.PeriodId).NotEmpty();
        RuleFor(x => x.MemberId).NotEmpty();
        RuleFor(x => x.Amount).GreaterThan(0).WithMessage("Amount must be positive");
        RuleFor(x => x.PaymentDate).NotEmpty();

        // Cross-field validation
        RuleFor(x => x)
            .MustAsync(async (cmd, ct) =>
            {
                // Check period is open, member is active, etc.
            }).WithMessage("Period is not open for contributions");
    }
}
```

### Balance Calculation Pattern

Balances are always derived from ledger entries:

```csharp
public decimal GetMemberBalance(Guid memberId, Guid circleId)
{
    // Never return a stored, mutable balance
    // Always calculate from authoritative ledger entries
    var entries = _dbContext.LedgerEntries
        .Where(e => e.MemberId == memberId && e.CircleId == circleId)
        .Where(e => e.DeletedAt == null)
        .OrderBy(e => e.CreatedAt)
        .ToList();

    return entries.Sum(e => e.Amount);
}
```

### API Error Handling Pattern

```csharp
// Global exception handler middleware
public async Task InvokeAsync(HttpContext context, RequestDelegate next)
{
    try
    {
        await next(context);
    }
    catch (ValidationException ex)
    {
        context.Response.StatusCode = 400;
        await WriteErrorAsync(context, "VALIDATION_ERROR", ex.Message, ex.Errors);
    }
    catch (NotFoundException ex)
    {
        context.Response.StatusCode = 404;
        await WriteErrorAsync(context, "NOT_FOUND", ex.Message);
    }
    catch (ForbiddenAccessException ex)
    {
        context.Response.StatusCode = 403;
        await WriteErrorAsync(context, "FORBIDDEN", ex.Message);
    }
    catch (DuplicateOperationException ex)
    {
        context.Response.StatusCode = 409;
        await WriteErrorAsync(context, "DUPLICATE_OPERATION", ex.Message);
    }
    catch (Exception ex)
    {
        // Log with correlation ID
        context.Response.StatusCode = 500;
        await WriteErrorAsync(context, "INTERNAL_ERROR", "An unexpected error occurred");
    }
}
```

## Database Patterns

### EF Core Best Practices

- Use `AsNoTracking()` for read-only queries
- Use `AsSplitQuery()` for queries loading large object graphs
- Eager load with `.Include()` for required related data
- Use raw SQL only for complex queries EF Core cannot express
- Migrations are reviewed before production application
- Always test migrations against both clean and existing databases

### Concurrency Control

Optimistic concurrency using EF Core concurrency tokens:

```csharp
entity.Property(e => e.RowVersion)
    .IsRowVersion(); // PostgreSQL uses bytea/timestamp
```

When a concurrency conflict occurs:

1. Catch `DbUpdateConcurrencyException`
2. Reload the entity from database
3. Re-apply changes
4. Retry or fail with appropriate error

### Enum Storage

Enums stored as strings (not integers) for readability:

```csharp
builder.Property(e => e.Status)
    .HasConversion<string>()
    .HasColumnType("text");
```

## Frontend Patterns

### API Service Pattern

```typescript
// services/contributionApi.ts
import { apiClient } from './apiClient'

export const contributionApi = {
  record: async (circleId: string, periodId: string, data: ContributionInput) => {
    return apiClient.post(`/circles/${circleId}/periods/${periodId}/contributions`, data, {
      headers: { 'Idempotency-Key': crypto.randomUUID() }
    })
  },
  list: async (circleId: string, periodId: string) => {
    return apiClient.get(`/circles/${circleId}/periods/${periodId}/contributions`)
  },
  get: async (contributionId: string) => {
    return apiClient.get(`/contributions/${contributionId}`)
  },
  reverse: async (contributionId: string, reason: string) => {
    return apiClient.post(`/contributions/${contributionId}/reverse`, { reason })
  }
}
```

### State Management Pattern (Pinia)

```typescript
// stores/contributionStore.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { contributionApi } from '@/services/contributionApi'

export const useContributionStore = defineStore('contribution', () => {
  const contributions = ref<Contribution[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  const unpaidCount = computed(() => contributions.value.filter(c => c.status === 'Unpaid').length)

  async function load(circleId: string, periodId: string) {
    loading.value = true
    error.value = null
    try {
      const { data } = await contributionApi.list(circleId, periodId)
      contributions.value = data
    } catch (e) {
      error.value = 'Failed to load contributions'
    } finally {
      loading.value = false
    }
  }

  async function record(data: ContributionInput) {
    loading.value = true
    try {
      const { data: newContribution } = await contributionApi.record(data.circleId, data.periodId, data)
      contributions.value.push(newContribution)
      return newContribution
    } finally {
      loading.value = false
    }
  }

  return { contributions, loading, error, unpaidCount, load, record }
})
```

## Configuration Management

### Environment-Based Configuration

```text
appsettings.json         (base configuration)
appsettings.Development.json  (local overrides)
appsettings.Staging.json    (staging overrides)
appsettings.Production.json   (production overrides)
```

Secrets managed via:

- Development: User Secrets (`dotnet user-secrets`)
- Production: Environment variables or Azure Key Vault (when adopted)
- Never in source control

### Configuration Hierarchy

```text
Environment Variable > appsettings.{Environment}.json > appsettings.json
```

### Required Configuration

| Setting | Description | Example |
|---------|-------------|---------|
| DatabaseConnectionString | PostgreSQL connection | `Host=...;Database=...` |
| JwtSecret | Token signing key | `super-secret-key-min-32-char` |
| JwtExpiryMinutes | Token lifetime | `15` |
| ApiBaseUrl | Frontend API URL | `https://api.circlefund.example.com` |
| Environment | Deployment environment | `Development` / `Production` |

## Background Jobs Pattern

```csharp
// Background job structure
public class GenerateReportJob : BackgroundJob
{
    public override async Task ExecuteAsync(CancellationToken ct)
    {
        // 1. Create job record (pending)
        // 2. Process (heavy work)
        // 3. Update job status (completed/failed)
        // 4. Notify user of result
    }
}
```

Job lifecycle:

```text
Created → Pending → Processing → Completed | Failed
```

Jobs are never expected to run indefinitely. Timeouts are enforced.
