# Domain Model — Integrations

**Subdomain:** Integrations · Iteration 3 (FR-I3-001..031)

Each integration is an adapter over an external service the app depends on but does not control.

## Notification

**Attributes:** `Id`, `UserId`, `Type` (email|push|sms), `ChannelPreference`, `Title`, `Message`, `ReferenceType`/`ReferenceId`, `Status` (Queued | Sent | Delivered | Failed), `RetryCount`, `SentAt`, `DeliveredAt`.

**Rules (BR-INT-001, NFR-032):** bounded retry; deduplication; a failed delivery never rolls back the originating business operation.

## File

**Attributes:** `Id`, `StorageReference`, `OwnerScope`, `FileName`, `ContentType`, `Size`, `ScanStatus` (Pending | Clean | Blocked), `Permissions`, `Version`, `CreatedAt`.

**Rules (NFR-031):** type/size validation before upload; malicious-content scan; path isolation; download authorization per ownership.

## External Identity

**Attributes:** `Id`, `UserId`, `Provider`, `ExternalSubject`, `LinkedAt`, `RevokedAt`.

**Rules (FR-I3-011..013):** link to existing or create new per policy; revocable by user; external claims validated.

## AI Parsed Transaction

**Attributes:** `Id`, `UserId`, `InterpretedRequest` (traceable original), `ProposedTransaction` (structured), `Status` (Proposed | Confirmed | Rejected), `SourceReference`.

**Rules (BR-INT-002, NFR-030):** AI output is a proposal; user confirms; AI never commits directly.

## Analytics

**Rules (FR-I3-019..022):** read-only aggregate queries; never alters authoritative financial records.

## Subscription

**Attributes:** `Id`, `UserId`, `PlanId`, `Entitlements`, `State` (Active | Expired | Cancelled), `ProviderReference`, `StateChangedAt`.

**Rules (FR-I3-023..026, NFR-002):** entitlements checked at authorization time; state changes recorded.

## Backup

**Attributes:** `Id`, `Schedule`, `Status` (Succeeded | Failed), `Metadata`, `VerifiedAt`, `RestoreAudit`.

**Rules (BR-INT-003, NFR-020):** failed backup detected/alerted; restore audited; reliable only after tested restore.