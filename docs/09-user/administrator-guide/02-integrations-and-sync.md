# Administrator Guide — Integrations & Sync

**Index:** `docs/09-user/administrator-guide.md`

## Integration Administration (Iteration 3)

| Integration | Responsibilities |
| --- | --- |
| Notification Service | Channels, retry policy, delivery status |
| File Storage | Type/size limits, scan, path isolation, download authorization |
| Authentication Provider | Enable/link external IdPs, linking policy |
| AI Service | Enable NL entry; AI proposes, user confirms |
| Analytics | Review collection analytics |
| Subscription Provider | Plans, entitlements, expiry |
| Backup Storage | Schedule, manual backup, metadata, restore, audit |

Every integration degrades gracefully.

## Sync Health
Review pending/syncing/synced/conflict/failed counts per circle. Triage unresolved conflicts (user resolution required).