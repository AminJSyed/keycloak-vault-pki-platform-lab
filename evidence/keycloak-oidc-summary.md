# Keycloak OIDC Evidence Summary

This lab validates a basic Keycloak-based IAM and OIDC authentication flow.

## Keycloak Objects Created

| Object | Value |
|---|---|
| Realm | iam-lab |
| Client | iam-lab-cli |
| User | amin |
| Role | platform-engineer |

## Flow Tested

1. Keycloak was started locally on port 8180.
2. Realm iam-lab was created.
3. Client iam-lab-cli was created.
4. User amin was created.
5. Realm role platform-engineer was created.
6. The role was assigned to the user.
7. An OIDC access token was generated.
8. The FastAPI backend validated the token using Keycloak JWKS.
9. The protected API returned user and role claims.

## Skills Demonstrated

- Keycloak IAM setup
- Realm configuration
- Client configuration
- User and role management
- OIDC token generation
- JWT validation
- JWKS-based verification
- Protected API integration
