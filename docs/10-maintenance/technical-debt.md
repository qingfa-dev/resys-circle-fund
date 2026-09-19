# Technical Debt — CircleFund

## Overview

This document tracks known technical debt, planned improvements, and strategies for managing and reducing technical debt in the CircleFund project.

## Technical Debt Categories

| Category | Description | Priority |
|----------|-------------|----------|
| **Code Quality** | Code that works but is hard to maintain, understand, or extend | Medium |
| **Architecture** | Design decisions that limit future flexibility | High |
| **Testing** | Insufficient test coverage or test quality | High |
| **Documentation** | Outdated or missing documentation | Medium |
| **Dependencies** | Outdated or problematic dependencies | Medium |
| **Infrastructure** | Limited monitoring, deployment automation, or CI/CD | Medium |
| **Performance** | Known performance bottlenecks | Low (current scale) |
| **Security** | Security improvements not yet implemented | High |

## Current Technical Debt Register

### Architecture

| ID | Description | Impact | Planned Resolution | Status |
|----|-------------|--------|-------------------|--------|
| TD-ARCH-001 | Offline mode deferred to Phase 4 | Users need reliable connectivity | Phase 4 | Accepted |
| TD-ARCH-002 | Caching not implemented | All queries hit database | Phase 2+ | Accepted |
| TD-ARCH-003 | Background job system not implemented | Notifications and reports are synchronous | Phase 2 | Accepted |
| TD-ARCH-004 | Redis not yet integrated | No distributed caching or session storage | Phase 2+ | Accepted |
| TD-ARCH-005 | Object storage not integrated | File uploads use local storage only | Phase 3+ | Accepted |
| TD-ARCH-006 | No message bus / outbox | Events handled synchronously | Phase 2+ | Accepted |

### Code Quality

| ID | Description | Impact | Planned Resolution | Status |
|----|-------------|--------|-------------------|--------|
| TD-CODE-001 | Codebase is new — no legacy debt | N/A | N/A | N/A |
| TD-CODE-002 | Vertical slice pattern to be established | New pattern needs consistent adoption | Ongoing | In Progress |
| TD-CODE-003 | AutoMapper profiles need configuration | Mapping code scattered | Phase 1 | Planned |

### Testing

| ID | Description | Impact | Planned Resolution | Status |
|----|-------------|--------|-------------------|--------|
| TD-TEST-001 | Unit test coverage targets not yet measured | Unknown coverage gaps | Phase 1 End | Planned |
| TD-TEST-002 | E2E test suite not yet built | UI not fully verified | Phase 1-2 | Planned |
| TD-TEST-003 | Concurrency tests not yet written | Risk of financial bugs under load | Phase 1-2 | Planned |
| TD-TEST-004 | API contract tests not yet built | API changes may break frontend | Phase 1-2 | Planned |

### Documentation

| ID | Description | Impact | Planned Resolution | Status |
|----|-------------|--------|-------------------|--------|
| TD-DOC-001 | Some API endpoints not documented | API consumers lack reference | Per feature | Planned |
| TD-DOC-002 | User documentation not yet localized | Vietnamese users may prefer local language | Phase 3 | Accepted |
| TD-DOC-003 | Onboarding guide not created | New contributors need ramp-up | Phase 2 | Planned |

### Dependencies

| ID | Description | Impact | Planned Resolution | Status |
|----|-------------|--------|-------------------|--------|
| TD-DEP-001 | Framework versions not yet stable | Future breaking changes | Minor upgrades per release | Planned |
| TD-DEP-002 | No dependency vulnerability scanning | Risk of known vulnerabilities | Phase 2+ | Planned |

### Infrastructure

| ID | Description | Impact | Planned Resolution | Status |
|----|-------------|--------|-------------------|--------|
| TD-INF-001 | No CI/CD pipeline | Manual deployment process | Phase 1-2 | Planned |
| TD-INF-002 | No staging environment | Cannot test pre-production | Phase 2 | Planned |
| TD-INF-003 | Limited monitoring setup | Operational blind spots | Phase 1-2 | Planned |
| TD-INF-004 | No automated backup | Data at risk | Phase 1 | Planned |

## Technical Debt Management Process

### Identification

Technical debt is identified through:

- Code review findings
- Testing gaps discovered during development
- Performance profiling
- Security audits
- Team retrospectives
- User feedback
- Incident post-mortems

### Tracking

All technical debt is tracked in this document with:

- Unique identifier (TD-CATEGORY-NNN)
- Clear description
- Impact assessment
- Planned resolution timeline
- Current status

### Prioritization

Technical debt is prioritized based on:

1. **Safety/Security:** Anything affecting financial data integrity or security
2. **Functionality:** Anything blocking feature development
3. **Maintainability:** Anything making code harder to work with
4. **Quality:** Anything affecting user experience
5. **Efficiency:** Anything affecting performance at scale

### Resolution

Each iteration should include capacity for technical debt reduction:

- **Iteration 1:** 20% of capacity for tech debt
- **Iteration 2+:** 10-15% of capacity for tech debt

Debt can be resolved by:

- Refactoring code
- Writing tests
- Updating documentation
- Upgrading dependencies
- Improving infrastructure

## Debt Review Cadence

| Review | Frequency | Owner |
|--------|-----------|-------|
| Sprint review | Every sprint | Development Team |
| Technical debt review | Every iteration | Tech Lead |
| Full audit | Quarterly | Architecture Team |
| Strategic review | Annually | Product Owner + Tech Lead |

## Debt Burndown Target

```text
Phase 1 End: All critical tech debt resolved
Phase 2 End: All high-priority tech debt resolved
Phase 3+: Continuous reduction, maintain low debt level
```

## Accepting New Technical Debt

New technical debt should only be accepted when:

- It enables a higher-value feature
- It is explicitly documented with a plan for resolution
- The team understands the long-term cost
- The debt does not affect financial integrity or security
- It is tracked and reviewed

**Never accept technical debt that:**

- Weakens financial data integrity
- Reduces security without a compensating control
- Prevents testing of financial operations
- Violates the project's core principles (auditability, consistency, etc.)
