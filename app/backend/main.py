import os
from typing import Any, Dict

import httpx
from fastapi import FastAPI, Header, HTTPException
from jose import jwt
from jose.exceptions import JWTError

app = FastAPI(
    title="IAM Platform Protected API",
    description="Sample API protected by Keycloak OIDC tokens.",
    version="1.0.0",
)

KEYCLOAK_ISSUER = os.getenv("KEYCLOAK_ISSUER", "http://localhost:8180/realms/iam-lab")
KEYCLOAK_INTERNAL_JWKS_URL = os.getenv(
    "KEYCLOAK_INTERNAL_JWKS_URL",
    "http://keycloak:8080/realms/iam-lab/protocol/openid-connect/certs",
)


@app.get("/")
def root() -> Dict[str, str]:
    return {
        "service": "IAM Platform Protected API",
        "status": "running",
        "auth": "Use /protected with a Keycloak Bearer token",
    }


@app.get("/health")
def health() -> Dict[str, str]:
    return {"status": "ok"}


async def get_jwks() -> Dict[str, Any]:
    async with httpx.AsyncClient(timeout=10) as client:
        response = await client.get(KEYCLOAK_INTERNAL_JWKS_URL)
        response.raise_for_status()
        return response.json()


async def validate_token(authorization: str | None) -> Dict[str, Any]:
    if not authorization or not authorization.lower().startswith("bearer "):
        raise HTTPException(status_code=401, detail="Missing Bearer token")

    token = authorization.split(" ", 1)[1]

    try:
        jwks = await get_jwks()
        unverified_header = jwt.get_unverified_header(token)
        kid = unverified_header.get("kid")

        key = next((k for k in jwks["keys"] if k.get("kid") == kid), None)
        if not key:
            raise HTTPException(status_code=401, detail="Matching JWKS key not found")

        claims = jwt.decode(
            token,
            key,
            algorithms=["RS256"],
            issuer=KEYCLOAK_ISSUER,
            options={"verify_aud": False},
        )

        return claims

    except JWTError as exc:
        raise HTTPException(status_code=401, detail=f"Invalid token: {str(exc)}") from exc
    except httpx.HTTPError as exc:
        raise HTTPException(status_code=503, detail=f"Unable to reach Keycloak JWKS: {str(exc)}") from exc


@app.get("/protected")
async def protected(authorization: str | None = Header(default=None)) -> Dict[str, Any]:
    claims = await validate_token(authorization)
    realm_roles = claims.get("realm_access", {}).get("roles", [])

    return {
        "message": "Access granted to protected IAM platform API",
        "subject": claims.get("sub"),
        "preferred_username": claims.get("preferred_username"),
        "email": claims.get("email"),
        "realm_roles": realm_roles,
        "issuer": claims.get("iss"),
    }
