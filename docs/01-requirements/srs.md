# Software Requirements Specification (SRS) — CircleFund

**Author:** Project Team
**Status:** Draft
**Version:** 0.1.0

---

## 1. Introduction

### 1.1 Purpose

This document is the authoritative Software Requirements Specification for CircleFund, an open-source application for managing rotating savings groups (Hụi). It defines what the system shall do, organized by product iteration.

### 1.2 Scope

CircleFund manages savings circles including members, contributions, payouts, financial ledger, and reporting. The system is organized into four iterations, each building upon the previous.

### 1.3 Definitions and Acronyms

See `docs/00-governance/glossary.md`.

### 1.4 References

- Project Charter: `docs/00-governance/project-charter.md`
- Development Plan: `docs/00-governance/development-plan.md`
- Business Rules: `docs/01-requirements/business-rules.md`
- Use Cases: `docs/01-requirements/use-cases.md`
- Domain Model: `docs/03-architecture/domain-model.md`

## 2. Overall Description

### 2.1 Product Perspective

CircleFund is a web application with PWA capabilities. The server is the authoritative source for financial records. The application uses a domain-oriented architecture with CQRS/vertical-slice patterns on the backend and Vue 3 on the frontend.

### 2.2 Product Functions

Core functions are organized by iteration:

- **Iteration 1:** Identity, circles, members, rounds, contributions, balances, dashboard, notifications
- **Iteration 2:** Payouts, bidding, interest, debt, ledger, audit, reports, export
- **Iteration 3:** Groups, roles, permissions, announcements, voting, rules, fines, chat, meetings, tasks
- **Iteration 4:** Accounts, budgets, invoices, documents, calendar, offline/sync, analytics, subscription, community

### 2.3 User Characteristics

| Actor | Description |
|-------|-------------|
| Visitor | Unauthenticated person |
| Registered User | Authenticated user |
| Circle Organizer (Chủ Hụi) | Manages a savings circle |
| Member (Hụi Viên) | Participates in circles |
| Treasurer | Manages financial operations |
| Secretary | Administrative tasks |
| Group Owner | Manages a collaboration group |
| Moderator | Moderates group content |
| Viewer | Read-only access |
| System Administrator | Platform administration |

### 2.4 Constraints

- Financial calculations use fixed-precision decimal arithmetic
- Server is authoritative for all financial records
- All financial mutations must be auditable
- No silent overwriting of financial history

### 2.5 Assumptions and Dependencies

- Users have access to modern web browsers
- Email service available for notifications
- PostgreSQL available for data persistence
- Redis available for caching (progressive)

## 3. Specific Requirements

### 3.1 Functional Requirements — Iteration 1

See `docs/01-requirements/` for detailed requirements by category.

**Identity & Account:**

- FR-I1-001: Account Registration
- FR-I1-002: Account Verification
- FR-I1-003: Authentication
- FR-I1-004: Logout
- FR-I1-005: Password Recovery
- FR-I1-006: Profile Management
- FR-I1-007: Application Lock

**Savings Circle:**

- FR-I1-008: Create Circle
- FR-I1-009: Support Circle Types
- FR-I1-010: View Circle
- FR-I1-011: Edit Circle
- FR-I1-012: Pause Circle
- FR-I1-013: Close Circle
- FR-I1-014: Archive Circle

**Periods:**

- FR-I1-015: Generate Periods
- FR-I1-016: Period Numbering
- FR-I1-017: Period Dates
- FR-I1-018: Period Status
- FR-I1-019: View Schedule
- FR-I1-020: Modify Schedule

**Members & Shares:**

- FR-I1-021: Add Member
- FR-I1-022: Member Status
- FR-I1-023: Member Profile
- FR-I1-024: Assign Share
- FR-I1-025: Multiple Shares
- FR-I1-026: Transfer Share
- FR-I1-027: Membership History

**Contributions & Balance:**

- FR-I1-028: Record Contribution
- FR-I1-029: Payment Status
- FR-I1-030: Contribution History
- FR-I1-031: Duplicate Prevention
- FR-I1-032: Correction (via compensating transaction)
- FR-I1-033: Member Balance
- FR-I1-034: Period Collection
- FR-I1-035: Circle Balance
- FR-I1-036: Recalculation

**Dashboard & Notifications:**

- FR-I1-037: Dashboard
- FR-I1-038: Reminders
- FR-I1-039: Reminder Status

### 3.2 Functional Requirements — Iteration 2

**Hốt (Payouts):** FR-I2-001 through FR-I2-005
**Bidding:** FR-I2-006 through FR-I2-011
**Rotation / Lottery:** FR-I2-012 through FR-I2-016
**Fixed Interest:** FR-I2-017 through FR-I2-020
**Reconciliation:** FR-I2-021 through FR-I2-024
**Debt:** FR-I2-025 through FR-I2-028
**Financial Ledger:** FR-I2-029 through FR-I2-033
**Profit & Loss:** FR-I2-034 through FR-I2-036
**Audit:** FR-I2-037 through FR-I2-039
**Reports:** FR-I2-040 through FR-I2-043
**Export:** FR-I2-044 through FR-I2-046

### 3.3 Functional Requirements — Iteration 3

Group, Roles, Announcements, Voting, Rules, Fines, Chat, Meetings, Tasks (FR-I3-001 through FR-I3-037)

### 3.4 Functional Requirements — Iteration 4

Accounts, Budgets, Invoices, Documents, Calendar, Import/Export, Offline/Sync, Backup/Restore, AI, Analytics, Sharing, Subscription, Community (FR-I4-001 through FR-I4-055)

## 4. Non-Functional Requirements

### 4.1 Security

- Authentication via ASP.NET Core Identity
- Role-based and resource-level authorization
- All API endpoints require authentication unless explicitly public
- Resource ownership checked for all data access
- Input validation on all user inputs
- Secure password hashing
- Audit logging for sensitive operations
- Rate limiting on authentication endpoints
- CSRF protection
- HTTPS enforced in production

### 4.2 Performance

- Dashboard loads within 2 seconds
- API responses within 500ms for standard operations
- Report generation may be asynchronous for large datasets
- Database queries optimized with appropriate indexes

### 4.3 Reliability

- Financial operations use database transactions
- Idempotency keys prevent duplicate processing
- Background jobs have retry logic
- System maintains 99.5% uptime target (post-MVP)

### 4.4 Auditability

- All financial operations recorded in audit trail
- Audit records capture: actor, action, timestamp, resource, before/after, correlation ID
- Financial history cannot be silently deleted or overwritten

### 4.5 Usability

- Responsive design for desktop, tablet, and mobile
- PWA installable on supported devices
- Intuitive navigation following common patterns
- Clear error messages in user's language

### 4.6 Scalability

- Horizontal scaling of API layer
- Database read replicas for reporting (Phase 2+)
- Background processing for heavy operations
- Caching for frequently accessed data (progressive)

### 4.7 Maintainability

- Clean architecture with separation of concerns
- Vertical slice organization
- Comprehensive automated tests
- Consistent coding standards
- Documentation maintained alongside code
