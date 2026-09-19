# AI / Natural-Language Entry — Functional Requirements

**Iteration:** 3 — Integrations (External Services)
**SRS:** `docs/01-requirements/srs.md` §3.3.4

## FR-I3-014

**Statement:** Users shall be able to enter a supported financial instruction in natural language (e.g., "Received 500 thousand from Nguyen A for round 5").

## FR-I3-015

**Statement:** The AI service shall transform the request into a structured proposed transaction.

## FR-I3-016

**Statement:** The system shall show the proposed interpretation before committing it.

## FR-I3-017

**Statement:** The user shall confirm the proposed transaction.

## FR-I3-018

**Statement:** The AI service shall not directly commit an unconfirmed financial operation (BR-INT-002, NFR-030).

**Related:** UC-I3-014..018, US-I3-007/008, BR-INT-002, NFR-030