# FAQ — CircleFund

## Getting Started

### What is CircleFund?

CircleFund is an open-source web application for managing rotating savings groups (Hụi). It helps groups track contributions, payouts, members, rounds, and financial records digitally.

### Who is CircleFund for?

CircleFund is designed for anyone who organizes or participates in rotating savings circles, including:

- Circle organizers (Chủ Hụi) who manage groups
- Members (Hụi Viên) who contribute and receive payouts
- Treasurers who handle financial operations
- Secretaries who manage administrative tasks

### Is CircleFund free?

Yes, CircleFund is open-source under the MIT License.

### What technology does CircleFund use?

- **Frontend:** Vue 3 + TypeScript (Progressive Web App)
- **Backend:** ASP.NET Core (C#)
- **Database:** PostgreSQL
- **Architecture:** Domain-oriented, vertical-slice design

## Account & Authentication

### I forgot my password. How do I reset it?

1. Go to the login page
2. Click "Forgot Password"
3. Enter your registered email/username
4. Check your email for a reset link
5. Click the link and set a new password
6. Log in with your new password

### Can I use CircleFund on my phone?

Yes! CircleFund is a Progressive Web App (PWA). You can access it from any modern mobile browser. On supported devices, you can also install it like a native app.

### How do I log out?

Click on your profile icon or avatar in the top right corner, then select "Logout."

## Circles

### What is a "Circle" (Dây Hụi)?

A Circle is a savings group — the core organizational unit in CircleFund. It represents a rotating savings group where members contribute money periodically and take turns receiving the pooled funds.

### How do I create a Circle?

1. Navigate to the Circles page
2. Click "Create Circle"
3. Enter the required information (name, type, contribution amount, schedule, etc.)
4. Click "Create"
5. Add members to your new circle

### What are the different Circle types?

| Type | Description |
|------|-------------|
| Non-interest (Không lãi) | Members take turns receiving the pooled amount |
| Fixed Interest (Lãi cố định) | Interest is calculated on contributions |
| Bidding (Đấu thầu) | Members bid for the right to receive funds |

### Can a member be in multiple Circles?

Yes, a member can participate in multiple circles simultaneously. Each membership is managed separately per circle.

### What happens if I close a Circle?

When a Circle is closed:

- No new contributions can be recorded
- The circle's financial records remain accessible
- Archived circles can be viewed for historical reference

## Contributions & Payments

### How do I record a contribution?

1. Open the relevant Circle
2. Click "Record Contribution"
3. Select the member, period, and enter the amount
4. Add payment details (date, method, reference)
5. Click "Confirm"

### Can I record a partial payment?

Yes, if the Circle settings allow partial payments, you can record a payment for less than the full contribution amount. The remaining balance will be tracked.

### How does the system prevent duplicate contributions?

Each financial operation requires a unique idempotency key. If the same operation is submitted twice, the system recognizes it and returns the same result without processing it again.

### How are balances calculated?

Balances are always calculated from the financial ledger — they are never manually edited. The system sums all relevant ledger entries (contributions and payouts) to determine current balances.

### What is a compensating transaction?

When a financial record needs correction, CircleFund does not overwrite history. Instead, it creates a reversal entry and a correction entry, preserving the original transaction while recording the correction. This keeps the complete financial history traceable.

## Financial Features

### What is Hốt (Payout)?

Hốt is the process where a member receives the pooled contributions for a round. This is a core feature of every savings circle.

### What is Bidding (Đấu thầu)?

In interest-bearing circles using the bidding model, members submit bids for the right to receive the pooled funds. The highest (or lowest, depending on configuration) bid wins.

### What is Reconciliation?

Reconciliation compares expected amounts (based on contributions and configured rules) against actual ledger entries for a period. Discrepancies are identified and must be resolved by an authorized user.

### Why does my balance show a different amount than expected?

Common reasons:

- Recent contribution not yet recorded
- Payout not yet processed
- Correction or reversal was applied
- Period not yet closed (expected amounts include pending items)

If the discrepancy persists, run a reconciliation or contact your Circle Organizer.

## Notifications & Reminders

### How do I set up reminders?

Reminders are configured by Circle Organizers in the circle settings. They are automatically sent to members before contribution due dates.

### Why didn't I receive a notification?

Possible reasons:

- Notifications are disabled in your settings
- Your email/notification preferences are not configured
- The reminder hasn't been scheduled yet
- Check spam/junk folder if via email

## Technical

### What browsers are supported?

CircleFund supports all modern browsers:

- Google Chrome (latest)
- Mozilla Firefox (latest)
- Apple Safari (latest)
- Microsoft Edge (latest)

### Can I use CircleFund offline?

Offline support is planned for a future release. Currently, an internet connection is required for all operations.

### How is my data secured?

- HTTPS encryption in transit
- Database encryption at rest
- Role-based access control
- Input validation and sanitization
- Audit logging of all financial operations
- No floating-point arithmetic for financial data

### Where is my data stored?

Your data is stored in a PostgreSQL database on the server hosting CircleFund. For self-hosted instances, this is on your infrastructure.

### How do I export my data?

Circle Fund supports exporting financial data to CSV and Excel formats. Navigate to the circle's Reports section and select the desired export format.

## Contact & Support

### I found a bug. What should I do?

1. Check the FAQ for known issues
2. Search existing issues on the project's GitHub repository
3. If it's a new bug, create a new issue with:
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Browser and device information
   - Screenshots (if helpful)

### I have a feature request. What should I do?

1. Check if the feature is already planned (check the roadmap)
2. Create an issue describing the feature
3. Explain the business need and benefit
4. Discuss with the community/maintainers
