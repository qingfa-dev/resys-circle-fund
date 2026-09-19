# Identity & Account — Functional Requirements

**Iteration:** 1 — Offline-First Core ROSCA Management
**SRS:** `docs/01-requirements/srs.md` §3.1.1

## FR-I1-001 — Account Registration

**Statement:** The system shall allow a visitor to create an account. Username/email/phone must be unique; the password must satisfy policy; registration data must be validated; account creation must produce a unique user identifier; duplicate accounts must be rejected.

**Acceptance Criteria:**
- Given valid registration data, When the visitor submits, Then an account is created with a unique identifier and a verification step is triggered.
- Given an already-used username/email/phone, When the visitor submits, Then registration is rejected with a duplicate-account error.

**Related:** UC-I1-001, US-I1-001, NFR-001 (Security), BR-CIR-001

## FR-I1-002 — Account Verification

**Statement:** The system shall allow a newly registered account to be verified.

**Acceptance Criteria:**
- Given a pending account, When the user completes verification, Then the account becomes active.
- Given an expired/invalid verification link, When used, Then verification is rejected.

**Related:** UC-I1-002, US-I1-002, NFR-001

## FR-I1-003 — Authentication

**Statement:** The system shall authenticate registered users.

**Acceptance Criteria:**
- Given valid credentials, When the user logs in, Then a session/token is issued.
- Given invalid credentials, When the user logs in, Then authentication fails with no information leakage.

**Related:** UC-I1-003, US-I1-003, NFR-001/002

## FR-I1-004 — Logout

**Statement:** The system shall allow users to terminate their authenticated session.

**Related:** UC-I1-004, NFR-001

## FR-I1-005 — Password Recovery

**Statement:** The system shall allow users to recover access after forgetting their password.

**Related:** UC-I1-005, US-I1-004, NFR-001. Requires connectivity.

## FR-I1-006 — Profile Management

**Statement:** A user shall be able to view and update personal information.

**Related:** UC-I1-006, US-I1-005, NFR-018 (Data Privacy)

## FR-I1-007 — Application Lock

**Statement:** The application shall optionally support PIN/biometric/device authentication where supported by the client platform.

**Related:** UC-I1-007, NFR-001

## FR-I1-040 — Offline Login (read-only)

**Statement:** A device that has previously authenticated shall be able to unlock the app offline via a locally-cached credential check, for a read-only session.

**Acceptance Criteria:**
- Given a previously-authenticated device without connectivity, When the user unlocks, Then a read-only session opens and writes remain queued.

**Related:** UC-I1-003, NFR-029 (Offline Reliability), FR-I1-041

> Account creation, verification, and password recovery require connectivity; login supports offline unlock only (read-only).