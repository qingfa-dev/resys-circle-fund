# Iteration Plan — Overview

**Index:** `docs/02-planning/iteration-plan.md`

```text
Iteration 1  Offline-First Core ROSCA Management
Iteration 2  Financial Operations (Offline-Capable)
Iteration 3  Integrations (External Services)
Iteration 4  Group Collaboration & Governance
Iteration 5  Advanced Platform
```

Every Iteration 1–2 slice follows the offline data flow from the start:

```text
Local action → Local write + local ID → Local queue → Sync → Conflict check → Commit or flag
```

## Cross-Cutting Engineering Epics

```text
X-E01 Validation
X-E02 Authorization
X-E03 Observability
X-E04 Reliability (transactions, idempotency, concurrency, retries, outbox, background jobs, recovery — including offline sync from Iteration 1)
X-E05 Testing
```

## Practical Development Order
1. Repo/tooling → 2. CI → 3. Base architecture → 4. Auth (offline cache) → 5. Local storage & queue → 6. Authorization → 7. ROSCA aggregate → 8. Contributions/Balance → 9. Sync & conflict → 10. Payout/Bidding/Rotation/Interest → 11. Ledger/Reports/Audit → 12. Offline financial → 13. Notification/Storage/Auth integrations → 14. AI/Analytics/Backup/Subscription → 15. Groups/roles → 16. Voting/Rules/Fines/Chat/Meetings/Tasks → 17. Accounts/Budgets/Invoices → 18. Documents/Calendar/Import/Export → 19. Sharing/Community.

Do not start AI, Chat, Community, or Subscription before the financial domain and its offline/sync behavior are stable.