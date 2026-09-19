# Security Design — Integration Security (Iteration 3)

## External Identity Provider (FR-I3-011 to 013)
- External login follows the same account-linking policy as native accounts.
- Linked identities can be viewed and revoked; external claims are validated, never trusted blindly.

## File Security (NFR-031)
- Type/size validation before upload.
- Malicious-content scan where supported.
- Storage-path isolation and download authorization per resource ownership.

## Subscription & Entitlement (FR-I3-023 to 026)
- Entitlements checked at authorization time, not only at login.
- Subscription state changes recorded and never forgeable client-side.

## AI Safety (NFR-030)
- AI output is always a proposal, shown to the user, requiring confirmation before any financial commit.