# Import — Functional Requirements

**Iteration:** 5 — Advanced Platform
**SRS:** `docs/01-requirements/srs.md` §3.5.6

## FR-I5-017

**Statement:** Users shall be able to upload supported data files.

## FR-I5-018

**Statement:** The system shall validate imported data before mutation.

## FR-I5-019

**Statement:** The system shall provide an import preview.

## FR-I5-020

**Statement:** The user shall explicitly confirm the import.

## FR-I5-021

**Statement:** The system shall provide an import result.

**Related:** UC-I5-024..029, US-I5-011/012, NFR-027 (Import Reliability)

> Import workflow: Upload → Validate file → Parse → Preview → Validate records → User confirmation → Transactional import → Import report.