# CircleFund

> An open-source app for managing rotating savings groups, contributions, payouts, members, and financial records.

**CircleFund** is an open-source web application for managing community-based rotating savings groups and their financial activities.

The project is inspired by the Vietnamese tradition known as **Hụi (hụi / họ / biêu / phường)** and uses English terminology in its software architecture to make the project easier to understand and contribute to internationally.

CircleFund is designed for individuals who organize and participate in savings circles and need a reliable way to manage members, contributions, rounds, payouts, balances, and financial records.

---

## What is "Hụi"?

**Hụi** is a traditional Vietnamese form of group-based asset transactions in which a group of people agree on participants, contribution amounts, timing, how contributions are made, how funds are received, and the rights and obligations of members.

Depending on the region, the same or closely related practice may be called:

* **Hụi** — commonly used in Southern Vietnam
* **Họ** — commonly used in Northern Vietnam
* **Biêu**
* **Phường**

Vietnamese law generally groups these terms together under **họ**.

In English, there is no single word that perfectly captures the Vietnamese concept. The closest established financial term is generally **Rotating Savings and Credit Association (ROSCA)**. Similar community-based arrangements exist under different names around the world.

Therefore, CircleFund uses:

> **Hụi → Rotating Savings Group / Savings Circle**

rather than translating Hụi into a single English word.

The Vietnamese term remains important because the application is specifically inspired by the Vietnamese form of this traditional financial practice.

---

## Vietnamese → English Terminology

CircleFund uses English names in its codebase while preserving the original Vietnamese concepts in the documentation.

| Vietnamese         | CircleFund English      | Description                                                          |
| ------------------ | ----------------------- | -------------------------------------------------------------------- |
| Hụi / Họ           | Rotating Savings Group  | The overall financial arrangement                                    |
| Dây hụi            | Savings Circle          | One specific group/circle                                            |
| Chủ hụi            | Circle Organizer        | Person responsible for organizing and managing the circle            |
| Con hụi            | Member / Participant    | Person participating in the circle                                   |
| Phần hụi           | Share                   | A member's share in a circle                                         |
| Kỳ hụi             | Round                   | A scheduled cycle of the circle                                      |
| Đóng hụi           | Contribution            | Money contributed by a member                                        |
| Lĩnh hụi / Hốt hụi | Payout                  | Receiving the pooled funds for a round                               |
| Đấu hụi / Đấu thầu | Bidding                 | Bidding mechanism used to determine the recipient in certain circles |
| Hụi không lãi      | Non-interest Circle     | Circle without an interest component                                 |
| Hụi có lãi         | Interest-bearing Circle | Circle involving an interest component                               |
| Công nợ            | Debt / Receivable       | Outstanding financial obligation                                     |
| Sổ hụi             | Financial Ledger        | Record of financial transactions                                     |
| Đối soát           | Reconciliation          | Comparing expected and actual financial records                      |

The exact terminology can vary by region and by how a particular Hụi is organized. CircleFund therefore treats these English terms as **software terminology**, not as perfect linguistic translations.

---

## ✨ Features

### Savings Circle Management

* Create and manage savings circles
* Configure contribution amounts
* Configure schedules
* Manage members
* Manage shares
* Generate rounds
* Track round status
* Track member participation
* View circle balances

### Contributions

* Record member contributions
* Track payment status
* Record payment dates
* Track outstanding contributions
* Prevent duplicate financial operations
* Maintain contribution history

### Payouts

* Record payouts
* Manage payout recipients
* Support different payout mechanisms
* Track payout amounts
* Track payout status
* Connect payouts with financial records

### Bidding

For supported interest-bearing circles:

* Record bids
* Determine the winning participant
* Record bidding information
* Calculate applicable amounts
* Maintain bidding history

### Financial Ledger

CircleFund treats financial history as an important part of the system.

The ledger is designed to provide:

* Transaction history
* Contributions
* Payouts
* Interest
* Fees
* Adjustments
* Reversals
* Audit information
* Reconciliation

Financial history should not simply be overwritten when something is wrong.

Instead, corrections should use appropriate compensating transactions so that the original financial activity remains traceable.

---

## 🏗️ Architecture

CircleFund follows a domain-oriented architecture.

```text
┌─────────────────────────────────┐
│          CircleFund Web         │
│        Vue + TypeScript         │
│              PWA                │
└────────────────┬────────────────┘
                 │
                 │ REST API
                 ▼
┌─────────────────────────────────┐
│       CircleFund API            │
│        ASP.NET Core             │
├─────────────────────────────────┤
│          Application            │
│             Domain              │
│        Authorization            │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│            EF Core              │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│           PostgreSQL            │
└─────────────────────────────────┘
```

The core domain can be represented as:

```text
Savings Circle
│
├── Members
│
├── Shares
│
├── Rounds
│   ├── Contributions
│   ├── Bids
│   ├── Winner
│   └── Payout
│
└── Financial Ledger
```

---

## 🛠️ Technology Stack

### Backend

* C#
* ASP.NET Core
* ASP.NET Core Web API
* Entity Framework Core
* PostgreSQL
* ASP.NET Core Identity

### Frontend

* Vue 3
* TypeScript
* Vue Router
* Pinia
* Progressive Web App (PWA)

### Testing

* xUnit
* Integration testing
* API testing
* Authorization testing
* Concurrency testing
* Playwright
* End-to-end testing

### Infrastructure

* Docker
* Git
* GitHub
* Background jobs
* Redis
* Object storage

Infrastructure components will be introduced progressively as needed.

---

## 🔐 Financial Integrity

Financial operations are one of the most important parts of CircleFund.

A contribution should not be treated as merely changing a number on a screen.

A typical operation should follow a transactional flow:

```text
Member makes contribution
        │
        ▼
API receives command
        │
        ▼
Validate domain rules
        │
        ▼
Begin database transaction
        │
        ├── Record contribution
        ├── Update balance
        ├── Record ledger transaction
        └── Record audit information
        │
        ▼
Commit transaction
```

The system should protect against:

* Duplicate submissions
* Partial financial updates
* Concurrent modifications
* Invalid state transitions
* Unauthorized financial operations

---

## 📱 Progressive Web App

CircleFund is designed as a web application with **PWA capabilities**.

The goal is to allow users to access CircleFund from:

* Desktop browsers
* Tablets
* Mobile browsers
* Installed PWA applications

The initial application does not require full offline functionality.

Offline operation and synchronization are considered advanced features because financial synchronization introduces additional challenges such as:

* Duplicate transactions
* Retry handling
* Conflicting changes
* Idempotency
* Synchronization ordering
* Conflict resolution

The server remains the authoritative source for financial records.

---

## 🧪 Testing Strategy

Financial functionality requires more than UI testing.

CircleFund aims to test important behavior at multiple levels:

```text
Unit Tests
     ↓
Domain Tests
     ↓
Integration Tests
     ↓
API Tests
     ↓
Authorization Tests
     ↓
Concurrency Tests
     ↓
End-to-End Tests
```

Important workflows should be tested end-to-end:

```text
Contribution
     ↓
Balance
     ↓
Payout
     ↓
Financial Ledger
     ↓
Reconciliation
```

---

## Security

CircleFund may contain sensitive financial and personal information.

Security considerations include:

* Authentication
* Authorization
* Resource ownership
* Group membership
* Role-based permissions
* Financial-operation permissions
* Input validation
* Secure password handling
* Audit logging
* Duplicate-operation protection
* Concurrency protection

Never use real financial or personal information for development or testing without appropriate safeguards.

---

## 🚀 Development Roadmap

CircleFund is developed incrementally.

### Phase 1 — Core Circle

* Identity
* Savings circles
* Members
* Shares
* Rounds
* Contributions
* Payment status
* Balances
* Dashboard
* Notifications

### Phase 2 — Financial Lifecycle

* Payouts
* Bidding
* Rotation
* Interest
* Debt
* Financial ledger
* Reconciliation
* Profit & loss
* Audit
* Reports
* Export

### Phase 3 — Groups & Collaboration

* Invitations
* Roles
* Permissions
* Voting
* Group rules
* Fines
* Appeals
* Chat
* Announcements
* Meetings
* Attendance
* Tasks

### Phase 4 — Productivity & Platform

* Accounts
* Transfers
* Budgets
* Invoices
* Documents
* Calendar
* Import/export
* Offline mode
* Synchronization
* Backup and restore
* Analytics
* AI-assisted workflows
* Sharing
* Subscription
* Community features

The roadmap is subject to change as the project develops.

---

## Contributing

Contributions are welcome.

Before implementing a significant change:

1. Check existing issues.
2. Open an issue when appropriate.
3. Explain the business requirement.
4. Discuss significant domain or architectural changes.
5. Keep pull requests focused.
6. Add tests for new behavior.
7. Update documentation when necessary.

For financial features, contributors should describe:

* Business rules
* Validation rules
* Transaction boundaries
* Balance effects
* Ledger effects
* Authorization requirements
* Concurrency considerations

---

## 📐 Development Principles

### Domain First

Business rules should live in the domain/application layer rather than being hidden inside UI code.

### Financial Consistency

Financial operations should be atomic whenever the operation affects multiple related records.

### Auditability

Important financial operations should remain traceable.

### No Silent Financial History Changes

Financial history should not be silently overwritten or deleted.

Corrections should be represented using appropriate compensating transactions when required.

### Security by Design

Authorization should be considered when a feature is designed, not added as an afterthought.

### Test Important Business Rules

Calculations, financial state transitions, and authorization rules should have automated tests.

### Small Increments

Development should proceed through small, working increments rather than attempting to build the entire platform at once.

---

## Disclaimer

CircleFund is open-source software intended to assist with the management and record-keeping of rotating savings groups.

It is not financial, legal, accounting, or investment advice.

Hụi and related arrangements are subject to applicable laws and regulations. Users are responsible for ensuring that their use of CircleFund complies with the laws and regulations applicable to them.

The software is provided without guarantees regarding its suitability for any particular financial, legal, accounting, or business situation.

---

## License

CircleFund is released under the MIT License.

See [`LICENSE`](LICENSE) for the complete license.

---

## Why CircleFund?

Hụi has traditionally been managed through notebooks, spreadsheets, conversations, and manually calculated records.

CircleFund aims to provide a modern digital system while preserving the underlying concept of community-based rotating savings.

The name **CircleFund** represents:

* **Circle** — a group of people participating together
* **Fund** — the shared pool of contributions

Together, **CircleFund** describes a shared financial circle without requiring users outside Vietnam to already know the Vietnamese word *Hụi*.

At the same time, the project keeps **Hụi** in its documentation because the Vietnamese concept and terminology are an important part of the project's origin and domain context.
