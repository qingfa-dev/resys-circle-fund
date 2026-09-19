# Domain Model — Collaboration

**Subdomain:** Group Collaboration & Governance · Iteration 4 (FR-I4-001..037)

## Group (aggregate root)

**Attributes:** `Id`, `Name`, `Description`, `OwnerId`, `Status` (Active | Archived), `Rules` (versioned), `CreatedAt`.

## Membership & Role

**Attributes:** `MembershipId`, `GroupId`, `UserId`, `Role` (Owner | Chair | Treasurer | Secretary | Moderator | Member | Viewer), `JoinedAt`, `RemovedAt`.

**Rules (FR-I4-006..009):** owner assigns roles; role-based permissions enforced; permission changes audited.

## Announcement

**Attributes:** `Id`, `GroupId`, `Title`, `Content`, `AuthorId`, `CreatedAt`, `Expiration`, `Attachments`, `Status` (Draft | Published | Archived).

## Vote

**Attributes:** `Id`, `GroupId`, `Question`, `Options`, `EligibleVoters`, `StartAt`, `EndAt`, `Quorum`, `VotingRules`, `Status`.

**Rules (FR-I4-013..018):** one vote per eligible user unless rules allow change; results and quorum calculated.

## Rule (versioned)

**Attributes:** `Id`, `GroupId`, `Version`, `Content`, `ActorId`, `Timestamp`. Changes append a new version; history preserved (FR-I4-019..021).

## Fine & Appeal

**Attributes:** `FineId`, `MemberId`, `Violation`, `RuleId`, `Amount`, `Date`, `ActorId`, `Evidence`, `Status` (Open | Appealed | Resolved); `AppealId`, `AppealStatus`.

## Message

**Attributes:** `Id`, `GroupId`, `SenderId`, `Body`, `ReplyToId?`, `VoiceNote?`, `Attachments`, `CreatedAt`. Permissions respect membership (FR-I4-026..030).

## Meeting

**Attributes:** `Id`, `GroupId`, `Title`, `Agenda`, `DateTime`, `Location/Link`, `Participants`, `Attendance`, `Minutes`.

## Task

**Attributes:** `Id`, `GroupId`, `Title`, `Description`, `AssigneeId`, `Priority`, `DueDate`, `Status`.

## Governing Rule

Collaboration features must not directly mutate Ledger, Contribution, Payout, or Balance — only via a controlled domain workflow that explicitly authorizes it.