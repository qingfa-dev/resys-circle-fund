# UI Design — CircleFund

## Design Principles

1. **Clarity over complexity:** Simple, clear interfaces for financial management
2. **Financial confidence:** Every financial action is confirmed and reversible
3. **Progressive disclosure:** Show essential information first, details on demand
4. **Accessibility:** WCAG 2.1 AA compliance
5. **Responsive:** Desktop, tablet, and mobile friendly
6. **Consistent:** Common patterns repeated throughout the application

## Design System

### Color Palette

| Token | Usage |
|-------|-------|
| Primary | Brand elements, active states |
| Success | Completed, positive amounts |
| Warning | Pending, overdue, attention needed |
| Danger | Errors, destructive actions, negative amounts |
| Neutral | Backgrounds, borders, text hierarchy |

### Typography

- **Font family:** System font stack (no custom font dependency)
- **Headings:** Semibold, clear hierarchy (h1-h6)
- **Body:** Regular weight, comfortable line height (1.5+)
- **Monospace:** For financial amounts (tabular figures)
- **Financial amounts:** Monospace with 2 decimal places, thousands separator

### Layout

- **Desktop:** Sidebar navigation + main content area
- **Tablet:** Collapsible sidebar + main content area
- **Mobile:** Bottom navigation + full-screen content

## Navigation

### Desktop Sidebar

```text
[Logo]
─────────
Dashboard
Savings Circles
  └── Circle Name (sub-item)
Members
Contributions
Periods / Rounds
Financial Ledger
Reports
─────────
Groups
  └── Group Name (sub-item)
Announcements
Voting
Tasks
─────────
Settings
  Profile
  Circle Settings
  Notifications
  Security
─────────
[User avatar]
```

### Mobile Bottom Navigation

```text
[Dashboard] [Circles] [Contributions] [Ledger] [Profile]
```

## Screen Patterns

### Dashboard

```text
┌─────────────────────────────┐
│ Good morning, [Name]        │
│                             │
│ ┌─────────┬─────────┬─────┐│
│ │ Circles │ Contributions │ Balance ││
│ │    3    │   2 Due  │ 5,000K ││
│ └─────────┴─────────┴─────┘│
│                             │
│ Upcoming Periods            │
│ ┌─────────────────────────┐│
│ │ Period 5 - Due in 3 days││
│ │ Period 6 - Due in 10 days││
│ └─────────────────────────┘│
│                             │
│ Recent Activity             │
│ ┌─────────────────────────┐│
│ │ Contribution received   ││
│ │ Period 4 - Member A     ││
│ │ 1,000,000 VND           ││
│ └─────────────────────────┘│
└─────────────────────────────┘
```

### Circle Details

```text
[← Back] Circle Name [● Active]
─────────
Overview  │ Members │ Periods │ Ledger │ Reports
─────────
Financial Summary
┌─────────────────────────────┐
│ Total Members: 5            │
│ Active Contributions: 3     │
│ Total Collected: 3,000,000  │
│ Outstanding: 2,000,000      │
└─────────────────────────────┘

Current Period
┌─────────────────────────────┐
│ Period 5: Due Jan 15        │
│ Collected: 2/5              │
│ [Progress bar visualization]│
└─────────────────────────────┘

Quick Actions
[Record Contribution] [View Ledger] [Generate Report]
```

### Record Contribution

```text
[← Back] Record Contribution
─────────
Circle: [Savings Circle A ▼]
Period: [Period 5 ▼]
Member: [Select member ▼]
Share: [1 share ▼]
Amount: [1,000,000] VND
Payment Date: [15/09/2026]
Method: [Cash / Bank Transfer / E-wallet ▼]
Reference: [Optional]
Note: [Optional]

Preview:
  Amount: 1,000,000 VND
  Member: Nguyen Van A
  Due: Sep 15, 2026
─────────
[Cancel] [Confirm]
```

**States:**

- **Loading:** Spinner on button, form disabled
- **Validation error:** Inline red highlights and messages
- **Duplicate warning:** "This contribution has already been recorded" (if idempotency detects)
- **Success:** Confirmation dialog, navigate to contribution list or detail
- **Error:** Clear error message, retry option

### Financial Ledger

```text
[← Back] Financial Ledger - Circle A
─────────
Filter by: [All Types ▼] [Date range ▼] [Member ▼]

Date │ Type │ Description │ Amount │ Balance │ Reference
─────┼──────┼─────────────┼───────┼─────────┼──────────
09/15│Contr.│ Member A - P5│+1M │1M │ CONTR-001
09/14│Payout│ Member B P4 │-800K │0 │ PAY-001
09/10│Contr.│ Member C - P5│+1M │1M │ CONTR-002
...
─────────
[Export CSV] [Export Excel]
```

## Financial Display Standards

### Amount Formatting

- Format: `X,XXX,XXX.VN` (thousands separator, 2 decimal places)
- Positive: `+1,000,000.00` (for credit entries)
- Negative: `-500,000.00` (for debit entries)
- Font: Monospace with tabular figures
- Color: Green for positive, red for negative (with patterns/icons for accessibility)

### Balance Display

- Summary balances shown in large, prominent typography
- Outstanding amounts highlighted in warning color
- Settlement status shown with clear visual indicators

### Status Indicators

| Status | Visual |
|--------|--------|
| Paid / Completed | Green checkmark |
| Pending | Yellow clock |
| Overdue | Red warning |
| Active | Green dot |
| Paused | Yellow pause icon |
| Closed | Gray lock |

## Form Patterns

### Financial Form Confirmation

Before any financial operation:

1. **Show summary** of all data (circle, member, amount, date)
2. **Require explicit confirmation** (button press, not auto-submit)
3. **Show idempotency status** ("This will be a new transaction")
4. **Display estimated balance impact** ("This will increase balance by 1,000,000 VND")
5. **Require re-authentication** for large amounts (configurable threshold)

### Error Handling in Forms

- Inline validation with specific error messages
- Field-level errors with red border + icon + message
- Form-level errors (e.g., server errors) at top with clear action
- Loading state with disabled form + spinner on submit button
- Success state with confirmation message + option to do another

## State Management (UX States)

Every screen should handle:

| State | Description |
|-------|-------------|
| Normal | Expected data displayed |
| Loading | Skeleton or spinner while fetching |
| Empty | No data to show, with guidance |
| Validation | Field errors highlighted |
| Error | System error with retry option |
| Success | Confirmation of action completed |
| Permission Denied | User lacks permission for this action |
| Offline | Cached data shown, sync indicator visible |
| Conflict | Data changed, user needs to refresh |

## Mobile-Specific Patterns

- Touch-friendly tap targets (minimum 44x44px)
- Swipe gestures for list actions (archive, delete)
- Bottom sheet modals for selection
- Pull-to-refresh for lists
- Number pad for amount input fields
- Camera integration for receipt scanning (progressive)

## Accessibility

- All images have alt text
- All interactive elements have ARIA labels
- Keyboard navigation works for all features
- Focus indicators visible
- Color contrast meets WCAG 2.1 AA
- Screen reader tested for key workflows
- Reduced motion respected (no unnecessary animations)
- Font size adjustable (no fixed px sizes for text)
