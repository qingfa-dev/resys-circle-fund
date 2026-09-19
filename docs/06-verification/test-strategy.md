# Test Strategy — CircleFund

## Overview

CircleFund requires thorough testing at multiple levels due to its financial nature. The testing pyramid guides investment: many domain/unit tests, moderate integration tests, moderate API tests, few end-to-end tests.

```text
                   E2E
                    ▲
                    │
               API Tests
                    ▲
                    │
           Integration Tests
                    ▲
                    │
              Unit Tests
                    ▲
                    │
              Domain Tests
```

## Test Levels

### Level 1: Domain/Unit Tests

**Scope:** Pure domain logic, no database, no framework

**Coverage:**

- Business rules (all rules in `docs/01-requirements/business-rules.md`)
- Financial calculations (contributions, payouts, interest, balances)
- State machine transitions (circle, period, contribution, member states)
- Validation logic
- Idempotency logic
- Concurrency scenarios
- Money handling and rounding
- Debt calculations
- Reconciliation logic

**Test Runner:** xUnit

**Test Pattern:**

```csharp
[Fact]
void RecordContribution_PositiveAmount_Succeeds()
{
    // Arrange
    var contribution = new Contribution(amount: 1000000m);

    // Act
    var result = contribution.Validate();

    // Assert
    Assert.True(result.IsValid);
}

[Fact]
void RecordContribution_ZeroAmount_Fails()
{
    // Arrange
    var contribution = new Contribution(amount: 0m);

    // Act
    var result = contribution.Validate();

    // Assert
    Assert.False(result.IsValid);
    Assert.Contains("Amount must be positive", result.Errors);
}
```

**Target:** All business rules tested, especially:

- Zero/negative amount handling
- Duplicate operation prevention
- Closed period rejection
- Missing member validation
- Multiple shares edge cases
- Late payment handling
- Partial payment scenarios
- Rounding edge cases
- Same-time concurrent updates

### Level 2: Integration Tests

**Scope:** API + Application + Database (test database, isolated per run)

**Test Infrastructure:**

- WebApplicationFactory for test server
- Test-specific database (created/destroyed per test or test class)
- Database migrations applied automatically
- Seed data for test scenarios
- No external dependencies (mocked)

**Coverage:**

- API endpoint behavior (all endpoints)
- Database state changes
- Authorization rules
- Request validation
- Error response formats
- Pagination and filtering
- Idempotency behavior
- Transaction rollback on failure

**Test Pattern:**

```csharp
[Fact]
async Task POST_contribution_WithValidData_CreatesContribution()
{
    // Arrange
    var client = _factory.CreateAuthenticatedClient();
    var request = new RecordContributionRequest { ... };

    // Act
    var response = await client.PostAsync($"/api/circles/{circleId}/periods/{periodId}/contributions", request);

    // Assert
    Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    var body = await response.Content.ReadAsAsync<ContributionResponse>();
    Assert.NotNull(body.Data);

    // Verify database state
    using var scope = _factory.Services.CreateScope();
    var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    var contribution = await dbContext.Contributions.FirstOrDefaultAsync(c => c.Id == body.Data.Id);
    Assert.NotNull(contribution);
    Assert.Equal(Amount, contribution.Amount);
}
```

### Level 3: API Contract Tests

**Scope:** Verify API contracts independently of frontend

**Coverage:**

- Response schema validation (all endpoints)
- Error response schema validation
- Status codes for all scenarios
- Validation behavior (all validation rules)
- Authorization behavior (all roles)
- Pagination, sorting, filtering behavior
- Idempotency header behavior

**Tools:** FluentAssertions, custom contract validators

### Level 4: End-to-End Tests

**Scope:** Full application through the UI (Playwright)

**Coverage:** Important business workflows, not every UI detail

**Key E2E Tests:**

```text
Test 1: Contribution Workflow
├── Create account
├── Create circle
├── Add members
├── Generate period
├── Record contribution
├── Verify balance
└── View dashboard

Test 2: Payout Workflow
├── Open period
├── Run payout
├── Verify ledger entries
├── Check member statement
└── Verify balance

Test 3: Bidding Workflow
├── Create bidding circle
├── Open period
├── Submit bids
├── Determine winner
├── Record payout
└── Verify results
```

### Level 5: Concurrency Tests

**Scope:** Verify correct behavior under concurrent operations

**Scenarios:**

- Two users recording contributions simultaneously for same member/period
- Two payout requests for same period
- Bid submission race conditions
- Member add/remove during contribution processing
- Balance recalculation concurrent with contribution recording

**Mechanisms:**

- Optimistic concurrency (EF Core RowVersion)
- Database locking (where needed)
- Unique constraints (duplicate prevention)
- Idempotency keys

**Verification:**

- No double payout
- No duplicate payment
- No incorrect balance
- No lost update
- No inconsistent ledger

## Test Organization

### Test Project Structure

```text
tests/
├── CircleFund.UnitTests/
│   ├── Domain/
│   │   ├── Contributions/
│   │   ├── Payouts/
│   │   ├── Bidding/
│   │   ├── Balances/
│   │   ├── Ledger/
│   │   └── ...
│   ├── Application/
│   │   ├── Validators/
│   │   ├── Handlers/
│   │   └── ...
│   └── Infrastructure/
│       └── ...
│
├── CircleFund.IntegrationTests/
│   ├── Api/
│   │   ├── Contributions/
│   │   ├── Payouts/
│   │   ├── Bidding/
│   │   └── ...
│   ├── Database/
│   │   └── MigrationTests.cs
│   └── Fixtures/
│       ├── TestWebFactory.cs
│       └── TestDataSeeder.cs
│
├── CircleFund.ApiTests/
│   ├── Contracts/
│   ├── Authorization/
│   └── Idempotency/
│
└── CircleFund.E2ETests/
    ├── Workflows/
    │   ├── ContributionWorkflow.cs
    │   ├── PayoutWorkflow.cs
    │   └── BiddingWorkflow.cs
    └── Pages/
        ├── LoginPage.cs
        ├── DashboardPage.cs
        └── ...
```

## Financial Calculation Testing

All financial calculations must be tested with edge cases:

### Money Tests

- [ ] Exact amounts
- [ ] Amounts with decimals
- [ ] Large amounts
- [ ] Very small amounts (minimum unit)
- [ ] Zero (rejected)
- [ ] Negative (rejected)
- [ ] Rounding (half-up, half-down, banker's)
- [ ] Multiplication precision
- [ ] Division precision and remainder handling
- [ ] Interest calculation over different periods

### Financial Workflow Tests

- [ ] Contribution → Balance update → Ledger entry (all in one transaction)
- [ ] Reversal → New correction entry (no overwriting)
- [ ] Payout → Balance update → Ledger entry
- [ ] Bidding → Winner → Payout → Ledger entry
- [ ] Period closing → Balance freeze → Final ledger entries

## Test Data Management

### Principles

- Each test should be independent
- Test data seeded automatically per test run
- No shared mutable state between tests
- Realistic data for financial scenarios
- No real financial or personal data

### Seed Data

```text
Test circles (3-5 with different types)
Test members (10-20 across circles)
Test periods (5-10 per circle)
Test contributions (various statuses)
Test ledger entries (matching contributions)
```

## Continuous Integration Testing

Every PR runs:

```text
Checkout
  ↓
Restore dependencies
  ↓
Build (with warnings as errors)
  ↓
Lint / formatting check
  ↓
Unit tests (>80% coverage on domain)
  ↓
Integration tests (all API endpoints)
  ↓
API contract tests
  ↓
Security scan
  ↓
Publish results
```

## Coverage Targets

| Level | Target | Notes |
|-------|--------|-------|
| Domain/Unit | >90% | Business rules must be fully tested |
| Integration | >70% | Critical paths fully tested |
| API Contract | 100% | All endpoints tested for basic behavior |
| E2E | ~20% | Key workflows only |

## Test Naming Convention

```text
[TestMethod]_[Scenario]_[ExpectedResult]
```

Examples:

- `RecordContribution_PositiveAmount_Succeeds`
- `RecordContribution_DuplicateKey_ReturnsCachedResult`
- `DetermineWinner_NoBids_ThrowsInvalidOperationException`
- `CalculateBalance_AfterContribution_ReflectsNewBalance`
