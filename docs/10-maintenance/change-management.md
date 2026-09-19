# Change Management — CircleFund

## Purpose

This document defines the process for managing changes to the CircleFund project, ensuring all changes are evaluated, approved, implemented, and documented properly.

## Change Categories

| Category | Description | Examples | Approval Level |
|----------|-------------|----------|----------------|
| **Standard** | Minor, well-understood changes | Bug fixes, small UI changes, text updates | Team Lead |
| **Major** | Significant changes to functionality | New features, architectural changes, DB schema changes | Product Owner + Tech Lead |
| **Emergency** | Urgent fixes or changes | Security patches, critical financial bugs | Incident Commander |

## Change Request Process

### 1. Initiation

Changes can be initiated by:

- Product Owner (business need)
- Development Team (technical improvement)
- Users (feedback/bug report)
- Operations (infrastructure, security)

### 2. Assessment

For every change request, assess:

- **Business impact:** Who is affected? How significantly?
- **Technical complexity:** How difficult to implement?
- **Risk:** What could go wrong? What's the blast radius?
- **Dependencies:** What else is affected?
- **Timeline:** How long will it take?
- **Cost:** What resources are required?

### 3. Prioritization

Changes are prioritized based on:

- Business value
- Urgency
- Risk reduction
- Dependencies
- Available capacity

All changes go into the product backlog unless they are emergency fixes.

### 4. Approval

| Change Type | Approval Required |
|-------------|------------------|
| Standard | Team Lead review |
| Major | Product Owner approval |
| Emergency | Incident Commander (after fact) |
| Architecture | Lead Architect + Product Owner |
| Financial rule | Product Owner + Domain Expert |

### 5. Implementation

Changes follow the development lifecycle:

```text
Change Request
  ↓
Assessment & Prioritization
  ↓
Approval
  ↓
Development (with tests)
  ↓
Code Review
  ↓
Testing
  ↓
Documentation Update
  ↓
Deployment
  ↓
Verification
```

### 6. Documentation

Every change must update relevant documentation:

| Documentation | When to Update |
|---------------|---------------|
| SRS (`docs/01-requirements/srs.md`) | When functional requirements change |
| Business Rules (`docs/01-requirements/business-rules.md`) | When business rules change |
| Architecture (`docs/03-architecture/`) | When architecture changes |
| ADRs (`docs/03-architecture/adr/`) | When an architecture decision is made/superseded |
| API Design (`docs/04-design/api-design.md`) | When API contracts change |
| Test Plan (`docs/06-verification/test-plan.md`) | When test scope changes |
| Release Notes (`docs/07-release/release-notes.md`) | For each release |
| User Documentation (`docs/09-user/`) | When user-facing features change |

## Emergency Change Process

For critical issues requiring immediate change:

1. **Identify** the issue and severity
2. **Assess** impact and urgency
3. **Implement** hotfix in a dedicated branch (`hotfix/...`)
4. **Test** minimum viable verification
5. **Review** by at least 1 team member
6. **Deploy** immediately
7. **Document** the change after deployment
8. **Back-merge** to develop for tracking
9. **Review** in post-incident analysis

## Change Log

Changes are tracked via version control (Git) and documented in release notes. Major architectural changes should have an ADR.

## Rejecting Changes

Changes can be rejected if:

- They conflict with business objectives
- They introduce unacceptable risk
- They cannot be tested adequately
- They violate core principles (financial consistency, auditability, etc.)
- They are not feasible within available resources

Rejected changes should be documented with reasons for future reference.
