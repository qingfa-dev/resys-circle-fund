# Data Model — Integration Tables (column-level)

Iteration 3+.

## Files

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| StorageReference | text | N | external object key |
| OwnerType / OwnerId | text/uuid | N | permission scope |
| FileName | text | N | |
| ContentType | text | N | validated type |
| Size | bigint | N | validated size |
| ScanStatus | int | N | Pending/Clean/Blocked |
| Version | int | N | |
| CreatedBy / CreatedAt | uuid/timestamptz | N | |

## ExternalIdentities

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| UserId | uuid | N | FK→AspNetUsers |
| Provider | text | N | |
| ExternalSubject | text | N | UNIQUE (Provider, ExternalSubject) |
| LinkedAt | timestamptz | N | |
| RevokedAt | timestamptz | Y | |

## Subscriptions

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| UserId | uuid | N | FK |
| PlanId | text | N | |
| Entitlements | jsonb | N | |
| State | int | N | Active/Expired/Cancelled |
| ProviderReference | text | Y | |
| StateChangedAt | timestamptz | N | |

## Backups

| Column | Type | Null | Notes |
| --- | --- | --- | --- |
| Id | uuid | N | PK |
| Schedule | text | Y | cron |
| Status | int | N | Succeeded/Failed |
| Metadata | jsonb | N | size, checksum, scope |
| VerifiedAt | timestamptz | Y | |
| RestoreAudit | jsonb | Y | |