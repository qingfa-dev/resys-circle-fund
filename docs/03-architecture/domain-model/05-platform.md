# Domain Model — Advanced Platform

**Subdomain:** Advanced Platform · Iteration 5 (FR-I5-001..031)

## Financial Account

**Attributes:** `Id`, `OwnerScope` (User/Group), `Type` (Cash | Bank | E-wallet | Other), `Balance` (derived), `Status`.

## Transfer

**Attributes:** `Id`, `FromAccountId`, `ToAccountId`, `Amount`, `Date`, `IdempotencyKey`. **Rule (FR-I5-004):** transfers create corresponding ledger records; idempotent (NFR-006).

## Budget

**Attributes:** `Id`, `Scope`, `Period`, `Category`, `TargetAmount`, `ActualAmount` (derived), `Variance`. **Rule (FR-I5-007):** utilization calculated.

## Invoice

**Attributes:** `Id`, `IssuerId`, `LineItems[]`, `Status` (Draft | Issued | Paid | PartiallyPaid | Overdue | Cancelled), `History` (preserved).

## Document

**Attributes:** `Id`, `OwnerScope`, `Metadata`, `Versions[]`, `Permissions`.

## Calendar

**Events from:** Rounds, payment reminders, meetings, tasks, votes, deadlines (FR-I5-016).

## Import

**Workflow (NFR-027):** Upload → Validate file → Parse → Preview → Validate records → User confirm → Transactional import → Import report. Row-level errors; retry after correction.

## Sharing

**Shareable representations:** Receipt, Statement, Report, Document (FR-I5-027). Privacy/permissions respected (NFR-018).

## Community

**Attributes:** `Post` (author, visibility), `Moderation` (moderator actions), `BusinessProfile` (directory).