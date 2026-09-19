# Identity & Account — Use Cases

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.1

## UC-I1-001 — Register Account
**Actor:** Visitor. Provide registration info → validate → create account → send verification. **Post:** account Pending.

## UC-I1-002 — Verify Account
**Actor:** Registered User. Follow link → confirm. **Post:** account Active.

## UC-I1-003 — Login
**Actor:** Registered User. Provide credentials → validate → issue token; offline login uses cached credential (FR-I1-040). **Post:** authenticated.

## UC-I1-004 — Logout
**Actor:** Registered User. Invalidate session. **Post:** unauthenticated.

## UC-I1-005 — Recover Account
**Actor:** Registered User. Request → reset password. **Post:** credentials updated.

## UC-I1-006 — Manage Profile
**Actor:** Registered User. View/update → validate → save.

## UC-I1-007 — Lock/Unlock Application
**Actor:** Registered User. PIN/biometric lock/unlock.

## Associated User Stories
- US-I1-001 — *As a visitor, I want to create an account so that I can use the application.*
- US-I1-002 — *As a registered user, I want to verify my account so that my identity can be confirmed.*
- US-I1-003 — *As a registered user, I want to log in securely so that I can access my data.*
- US-I1-004 — *As a user, I want to reset my password so that I can regain access to my account.*
- US-I1-005 — *As a user, I want to manage my profile so that my personal information remains accurate.*