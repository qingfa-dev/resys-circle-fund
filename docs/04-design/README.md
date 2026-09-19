# 04-design — README

## Purpose

Detailed technical and UX design: API contracts, security controls, the offline synchronization engine, and the UI design system.

## Key Terms

- **API design** — endpoints, request/response conventions, errors.
- **Security design** — threat model, authn/authz, input validation, encryption.
- **Synchronization design** — offline queue, sync flow, conflict resolution.
- **UI design** — design system, screens, form/state patterns, accessibility.

## Contents

```
04-design/
├── README.md
├── api-design.md               index → api-design/ (9)
├── security-design.md          index → security-design/ (8)
├── synchronization-design.md   index → synchronization-design/ (6)
└── ui-design.md                index → ui-design/ (5)
```

## Usage

- **Add/change an endpoint:** `api-design/01-conventions.md` then the relevant domain file.
- **Review a control:** `security-design/`.
- **Understand offline behavior:** `synchronization-design/`.
- **Build a screen:** `ui-design/`.

## Cross-references

- Structure it realizes: `../03-architecture/`
- Requirements it satisfies: `../01-requirements/`
- How to build it: `../05-development/`