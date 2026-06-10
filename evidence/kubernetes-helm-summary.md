# Kubernetes and Helm Evidence Summary

This lab validates deployment of the protected platform API to Kubernetes using Helm.

## Kubernetes Runtime

Local Kubernetes was created using kind.

- Cluster: iam-platform-lab
- Namespace: iam-platform
- Helm release: platform-api

## Containerized Access Model

The API is exposed without kubectl port-forward.

- Host port: 8101
- kind node port: 30080
- Kubernetes service: platform-api
- Container port: 8000

## Helm Chart

A custom Helm chart was created for the protected FastAPI API.

The chart includes:

- Deployment
- NodePort Service
- Environment configuration
- Readiness probe
- Liveness probe
- CPU and memory requests
- CPU and memory limits

## API Authentication

The Kubernetes-hosted API validates Keycloak-issued JWT tokens.

Authentication flow:

1. Token is issued by Keycloak realm iam-lab.
2. Token is sent to the Kubernetes-hosted API.
3. API retrieves JWKS from Keycloak.
4. API validates the token.
5. API returns user and role claims.

## Successful Validation

The Kubernetes-hosted API returned a successful protected response using a Keycloak-issued Bearer token.

Validated claims included:

- preferred_username: amin
- realm role: platform-engineer
- issuer: http://localhost:8180/realms/iam-lab

## Skills Demonstrated

- Kubernetes application deployment
- Helm chart authoring
- Kubernetes NodePort service exposure
- kind port mapping
- OIDC/JWT validation from a Kubernetes workload
- Keycloak integration with Kubernetes-hosted services
- Production mapping for GKE/OpenShift-style deployments
