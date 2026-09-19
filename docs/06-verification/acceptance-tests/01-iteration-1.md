# Acceptance Tests — Iteration 1 (Offline-First Core)

## Identity & Circle

```gherkin
Scenario: Register account
  Given a visitor provides valid registration data
  When they submit
  Then an account is created and verification is sent

Scenario: Duplicate registration rejected
  Given an account exists for an email
  When a visitor registers with the same email
  Then registration is rejected

Scenario: Organizer creates a circle offline
  Given a Circle Organizer is offline
  When they create a Savings Circle
  Then the circle is stored locally with a pending status
  And syncs automatically once connectivity returns
```

## Contribution

```gherkin
Scenario: Record contribution
  Given an open round and an active member
  When the organizer records a contribution of 1,000,000 VND
  Then the contribution is committed atomically
  And member balance increases by 1,000,000 VND
  And a ledger entry is created

Scenario: Duplicate contribution prevented
  Given a contribution already recorded for member/round/share
  When the same contribution is submitted again
  Then it is rejected (or returns the cached result)
```

## Balance

```gherkin
Scenario: Balance derived from ledger
  Given three contributions of 1,000,000 VND each
  When member balance is viewed
  Then it equals 3,000,000 VND
```

## Offline & Sync

```gherkin
Scenario: Offline contribution syncs exactly once
  Given a contribution was recorded while offline
  And the device later regains connectivity
  When the queued operation synchronizes
  Then the contribution is committed exactly once
  And it is marked synced (no longer "pending")

Scenario: Conflicting share edit surfaced
  Given two devices queue conflicting edits to the same share
  When either device syncs
  Then both versions are shown for the user to resolve
  And neither change is silently discarded
```