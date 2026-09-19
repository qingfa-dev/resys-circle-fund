# Synchronization Design — Read Cache & Status Indicator

## Read-Only Cache (IndexedDB)

Cached entities and age display:

| Entity | Cache | Stale display |
| --- | --- | --- |
| Circle summary | name, status, member count, balance | "2 hours old" |
| Member list | name, status, share count | timestamp |
| Round schedule | number, date, status | timestamp |
| Recent contributions | last 10/member | timestamp |
| Current balances | derived (excludes pending) | timestamp |

Invalidation: cache refreshed on successful sync; re-validated on `online`.

## Pending-Sync Distinction

A record with `status ∈ {pending, syncing, conflict}`:
- rendered distinctly (dashed/amber icon, "pending sync" label);
- excluded from balance/ledger/report totals (FR-I2-049).

```text
authoritative = records WHERE syncStatus IN ('synced')
```

## Sync Status Indicator

| Icon/state | Meaning |
| --- | --- |
| Online, synced | all operations synchronized |
| Online, pending | operations awaiting sync |
| Syncing | sync in progress |
| Conflict | conflict detected (tap to resolve) |
| Offline | no connectivity |

Physical placement: persistent top-of-screen banner (or status chip), plus a per-record marker in tables/forms.