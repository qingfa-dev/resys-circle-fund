# 06-verification — README

## Purpose

How CircleFund is verified: test strategy, test plan, per-iteration test cases, acceptance tests, and requirement-to-test traceability.

## Key Terms

- **Test Strategy** — levels (unit → integration → API → concurrency → offline/sync → E2E) and coverage targets.
- **Test Plan** — what is tested per iteration.
- **TC (Test Case)** — `TC-<iter>-NNN`: scenario, steps, expected.
- **AT (Acceptance Test)** — `AT-<iter>-NNN`: Given/When/Then.

## Contents

```
06-verification/
├── README.md
├── test-strategy.md            levels, coverage, naming
├── test-plan.md                index → test-cases/
├── requirements-traceability.md test↔requirement matrix
├── test-cases/                 5 files (per iteration), per-TC steps/expected
├── acceptance-tests/           6 files (5 iterations + non-functional), Gherkin
└── test-results/               (output; intentionally empty)
```

## Usage

- **Choose a test level:** `test-strategy.md`.
- **Find a test case:** `test-cases/<NN>-iteration-*.md`.
- **Find an acceptance criterion:** `acceptance-tests/<NN>-iteration-*.md`.
- **Trace a requirement to a test:** `requirements-traceability.md`.

## Cross-references

- What's being tested: `../01-requirements/`
- How it's built: `../03-architecture/`, `../04-design/`