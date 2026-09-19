# Monitoring — Financial Operation Tracing

Every financial operation must be traceable end-to-end through a correlation ID. The expected chain:

```text
OperationRequested
  → Committed
    → LedgerEntryCreated
      → BalanceUpdated
        → NotificationSent (best-effort)
```

## Invariant Checks (alert on breakage)

| Missing link | Severity |
| --- | --- |
| Committed operation with no ledger entry | **Critical** |
| Ledger entry with no balance update | **Critical** |
| Financial mutation with no audit record | Critical |
| Balance updated but notification failed | Warning |

## Query Examples

```sql
-- contributions without a matching ledger entry
SELECT c.id FROM contributions c
WHERE c.sync_status = 'synced'
  AND NOT EXISTS (SELECT 1 FROM ledger_entries l
                  WHERE l.reference_type='Contribution' AND l.reference_id=c.id);

-- financial mutations without audit
SELECT c.id FROM contributions c
WHERE NOT EXISTS (SELECT 1 FROM audit_records a
                  WHERE a.resource_type='Contribution' AND a.resource_id=c.id);
```

The sync-health dashboard trends counts of these broken chains per circle.