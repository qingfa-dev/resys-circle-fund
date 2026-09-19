# Migration Policy — CircleFund

## Purpose

This document defines the policy for database migrations, ensuring all schema changes are safe, tested, reversible, and properly documented.

## Scope

This policy applies to all database schema changes including:

- New tables, columns, indexes
- Column type changes
- Constraint additions/removals
- Foreign key changes
- Seed/reference data updates
- Data migrations

## Migration Principles

### 1. Always Reversible

Every migration must be reversible. If a migration cannot be rolled back safely, document the limitation and accept the risk.

### 2. Backward Compatible (Where Possible)

Migrations should be backward-compatible where the application code is deployed before or alongside the database change.

Safe patterns:

- Adding a new column (nullable, no default or with default that doesn't lock table)
- Adding a new table
- Adding an index
- Adding a new row of seed data

Risky patterns (require careful coordination):

- Renaming columns (requires code + migration coordination)
- Removing columns (requires code + migration coordination)
- Changing column types (requires careful planning)
- Dropping tables (requires data export and code coordination)

### 3. Safe for Production

Migrations must be tested and safe for production databases:

- Avoid table locks on large tables
- Use `CREATE INDEX CONCURRENTLY` for indexes on large tables
- Be aware of migration duration on large datasets
- Test on realistic data volumes

## Migration Development Process

### Step 1: Create Migration

```bash
dotnet ef migrations add MigrationName --project CircleFund.Infrastructure
```

### Step 2: Review Migration SQL

Before committing, review the generated SQL:

```bash
dotnet ef migrations script --project CircleFund.Infrastructure
```

Check for:

- Table locks
- Long-running operations
- Missing indexes
- Data integrity issues
- Backward compatibility

### Step 3: Test Migrations

Every migration must be tested on:

1. **Clean database** — Migration applies cleanly from scratch
2. **Existing database** — Migration applies to current production schema
3. **Rollback** — Migration can be rolled back safely

### Step 4: Code Review

All migrations are code reviewed as part of the PR process. Reviewers check:

- Correctness of SQL
- Performance implications
- Reversibility
- Data integrity
- Naming conventions

## Migration Types

### DDL Changes (Schema)

| Change Type | Risk | Notes |
|------------|------|-------|
| Add table | Low | Safe, always reversible |
| Add column | Low | Safe if nullable or has safe default |
| Add index | Low-Medium | Use CONCURRENTLY on large tables |
| Add constraint | Medium | Validate existing data first |
| Rename column | High | Requires code coordination |
| Change column type | High | Test on realistic data volumes |
| Drop column | High | Requires code coordination |
| Drop table | Critical | Data must be exported first |

### DML Changes (Data)

Data migrations should:

- Be idempotent (safe to re-run)
- Handle zero rows gracefully
- Be batched for large datasets
- Be logged for auditing
- Include verification step

Example:

```csharp
// Data migration
public void Migrate(MigrationBuilder migrationBuilder)
{
    // Batch update in chunks to avoid locking
    const int batchSize = 1000;
    int totalUpdated = 0;
    
    while (true)
    {
        int updated = ExecuteRawSql(
            @"UPDATE ""Members"" 
              SET ""Status"" = 1 
              WHERE ""Status"" = 0 
              AND ""Id"" IN (
                  SELECT ""Id"" FROM ""Members"" 
                  WHERE ""Status"" = 0 
                  LIMIT {batchSize}
              )");
        
        if (updated == 0) break;
        totalUpdated += updated;
        
        // Log progress for long migrations
        Log.Information("Updated {Total} members", totalUpdated);
    }
}
```

## Migration Testing

### Test Checklist

```text
[ ] Migration applies cleanly to empty database
[ ] Migration applies cleanly to existing database (current version)
[ ] All seed data loads correctly
[ ] Rollback script executes successfully
[ ] Application works with migrated database
[ ] Existing tests pass on migrated database
[ ] Performance acceptable on large datasets
[ ] No data lost or corrupted
```

### Test Environments

| Environment | Test | Frequency |
|-------------|------|-----------|
| Local Development | Migration applies | Every migration |
| Test Database | Full migration + tests | Every PR |
| Staging | Migration + realistic data | Before release |
| Production | Via deployment pipeline | Every release |

## Migration Deployment

### Deployment Order

For backward-compatible migrations:

```text
1. Deploy application code (new code works with old and new schema)
2. Run database migration
3. (Optional) Deploy follow-up code that uses new features
```

For non-backward-compatible migrations (breaking changes):

```text
1. Deploy code that handles both old and new schema (compatibility layer)
2. Run database migration
3. Deploy code that uses new schema exclusively
4. (After safe period) Remove compatibility layer in a future release
```

### Rollback Strategy

If migration fails:

1. Stop deployment
2. Execute rollback script
3. Verify database state
4. Investigate and fix migration
5. Re-attempt migration

If migration succeeds but causes issues:

1. Assess severity
2. If data/corruption: restore from backup
3. If application issue: deploy fix or rollback code
4. Document incident

## Migration Safety Rules

### Never Do These in Production Without Preparation

- Drop columns without prior deprecation period
- Change data types on large tables without testing
- Run unbounded operations on large tables without batching
- Remove constraints without verifying data
- Delete data without backup

### Always Do These

- Test migrations on realistic data volumes
- Include verification queries in migrations where possible
- Log migration progress for long operations
- Use transactions where appropriate
- Test rollback procedures

## Seed Data Management

Seed data (reference data, initial configurations):

- Included in migrations
- Idempotent (safe to re-run)
- Version controlled
- Cannot be modified without migration

Example pattern:

```csharp
modelBuilder.Entity<CircleType>().HasData(
    new CircleType { Id = 1, Name = "Non-interest", Description = "Không lãi" },
    new CircleType { Id = 2, Name = "Fixed Interest", Description = "Lãi cố định" },
    new CircleType { Id = 3, Name = "Bidding", Description = "Đấu thầu" }
);
```
