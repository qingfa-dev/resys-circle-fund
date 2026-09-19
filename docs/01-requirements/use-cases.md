# Use Cases — Index

Use cases are decomposed into per-feature files under `use-cases/`, ordered by iteration. Each file contains the feature's use cases (with main flow) and its associated user stories.

```text
use-cases/
├── 01-iteration-1/   08 files (~45 use cases)
├── 02-iteration-2/   12 files (~48 use cases)
├── 03-iteration-3/   07 files (~31 use cases)
├── 04-iteration-4/   09 files (~46 use cases)
└── 05-iteration-5/   09 files (~35 use cases)
```

## Iteration 1 — Offline-First Core
`01-identity-and-account`, `02-savings-circle`, `03-round-scheduling`, `04-member-and-share`, `05-contribution`, `06-balance`, `07-dashboard-and-notifications`, `08-offline-capture-and-sync`.

## Iteration 2 — Financial Operations
`01-payout-draw`, `02-bidding`, `03-no-interest-rotation-lottery`, `04-fixed-interest`, `05-reconciliation`, `06-debt-management`, `07-financial-ledger`, `08-profit-and-loss`, `09-audit`, `10-reports`, `11-export`, `12-offline-aware-financial-handling`.

## Iteration 3 — Integrations
`01-notification-integration`, `02-file-storage-integration`, `03-external-auth-provider`, `04-ai-natural-language-entry`, `05-analytics-integration`, `06-subscription-billing`, `07-backup-integration`.

## Iteration 4 — Group Collaboration
`01-group`, `02-roles-and-permissions`, `03-announcements`, `04-voting`, `05-group-rules`, `06-fines-and-appeals`, `07-communication`, `08-meetings`, `09-tasks`.

## Iteration 5 — Advanced Platform
`01-financial-accounts`, `02-budget-management`, `03-invoice-management`, `04-documents`, `05-calendar`, `06-import`, `07-export`, `08-sharing`, `09-community`.

Each use case carries a stable ID (`UC-<iter>-NNN`) traceable to the corresponding FR and US per the traceability matrix in `requirements-traceability.md`.