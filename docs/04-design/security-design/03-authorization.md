# Security Design — Authorization

## Model

```text
Authentication → User → Group Membership → Role → Permission → Resource Ownership → Action
```

## Middleware Enforcement Order

```text
Authentication (401 if no/invalid token)
  → Authorization policy (403 if role mismatch)
    → Resource ownership check (403 if not member/owner)
      → Domain state check (422 if invalid transition)
```

## Check Function

```csharp
bool CanPerform(user, resource, action) =>
    isAuthenticated(user)
    && hasRole(user, resource.scope, requiredRole(action))
    && isMember(user, resource.circleId)     // or resource owner
    && isValidState(resource, action);
```

## Role → Permission Matrix (illustrative)

| Action | Organizer | Treasurer | Member | Viewer |
| --- | --- | --- | --- | --- |
| Create/edit circle | ✓ | | | |
| Record contribution | ✓ | ✓ | | |
| View own contribution | ✓ | ✓ | ✓ | ✓ |
| Record payout draw | ✓ | ✓ | | |
| Generate reports | ✓ | ✓ | | ✓(read) |

## Resource Ownership
Every data access verifies: does the user belong to this circle, and is the resource in a valid state for the action? Enforcement is duplicated at API (policy), application (handler check), and domain (invariant) layers — no single point of failure.