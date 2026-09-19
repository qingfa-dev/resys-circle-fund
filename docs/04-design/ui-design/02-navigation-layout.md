# UI Design — Navigation & Layout

## Desktop Sidebar

```text
[Logo CircleFund]
─────────────
Dashboard
Savings Circles      (expandable → each circle)
Members
Contributions
Rounds
Financial Ledger
Reports
─────────────
Groups               (I4)
Announcements        (I4)
Voting               (I4)
Tasks                (I4)
─────────────
Settings
  Profile
  Circle Settings
  Notifications
  Security
─────────────
[user avatar / sync indicator]
```

## Mobile Bottom Navigation

```text
[Dashboard]  [Circles]  [Contributions]  [Ledger]  [Profile]
```

## Breadcrumbs & Header
- Secondary screens: `← Back` + page title + contextual action (primary).
- Persistent sync indicator chip in the header (see sync design).

## Routing
`/dashboard`, `/circles`, `/circles/:circleId` (+ tabs `members`, `rounds`, `ledger`, `reports`), `/circles/:circleId/contributions/new`, `/sync`.