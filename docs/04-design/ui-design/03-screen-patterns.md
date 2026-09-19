# UI Design — Screen Patterns

## Dashboard

```text
Good morning, {Name}          [sync chip]

┌──────────┬──────────────┬──────────┐
│ Circles  │ Contrib. due │ Balance  │
│   3      │      2       │  5,000K  │
└──────────┴──────────────┴──────────┘

Upcoming Rounds                [view all]
  Round 5 — due in 3 days · Circle A
  Round 6 — due in 10 days · Circle B

Recent Activity
  Contribution received · Round 4 · Member A · 1,000,000 VND
```

## Circle Details

```text
[←] Circle A  [● Active]        [Record Contribution]

Tabs: Overview | Members | Rounds | Ledger | Reports

Financial Summary
  Total members: 5   Active contributions: 3
  Total collected: 3,000,000   Outstanding: 2,000,000

Current Round
  Round 5 · due Jan 15 · Collected 2/5  [progress bar]
```

## Record Contribution (form + preview)

Fields: Circle (locked), Round, Member, Share, Amount, Payment date, Payment method, Reference, Note. Right rail: preview card (amount, member, due) + estimated balance impact + pending-sync note if offline.

## Financial Ledger

```text
Filters: [All types ▾][Date range ▾][Member ▾]     [Export CSV][Export Excel]

Date     Type       Description       Amount    Balance    Reference
09/15    Contr.     Member A · R5     +1,000,000  1,000,000  CONT-001
09/14    Payout     Member B · R4      -800,000    200,000  PAY-001
```

Rows with `pending sync` show an amber "pending" chip and are excluded from the balance column total.

## Financial Display Standards
- `+`/`-` sign, monospace tabular figures, 2 decimals.
- Status chips: Paid/green, Pending/amber, Overdue/red, Active/green-dot, Paused/amber-pause, Closed/gray-lock.