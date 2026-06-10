# Kubernetes and Helm Deployment

This phase demonstrates deployment of the Keycloak-protected FastAPI platform API to Kubernetes using Helm.

## What is deployed

- FastAPI protected API
- Kubernetes Deployment
- Kubernetes NodePort Service
- Readiness probe
- Liveness probe
- Resource requests and limits
- Helm chart values for repeatable deployment
- kind cluster port mapping for browser/curl access without kubectl port-forward

## Local Kubernetes Runtime

The lab uses kind for local Kubernetes testing.

Cluster name:

- iam-platform-lab

Namespace:

- iam-platform

Helm release:

- platform-api

## Access Model

The API is exposed without kubectl port-forward.

Flow:

- Host port: 8101
- kind node port: 30080
- Kubernetes service: platform-api
- Container port: 8000

Local API URL:

- http://localhost:8101

## Authentication Flow

1. Keycloak runs locally through Docker Compose on port 8180.
2. The user gets an OIDC access token from Keycloak.
3. The Kubernetes-hosted API receives the Bearer token.
4. The API fetches Keycloak JWKS through host.docker.internal.
5. The API validates the JWT issuer and signature.
6. The API returns protected claims such as username and roles.

## Why this matters

This shows how a containerized application running on Kubernetes can integrate with an external IAM platform such as Keycloak.

The same model can be extended to GKE, OpenShift, AKS, EKS, or an internal developer platform.

## Production Mapping

| Lab Component | Production Equivalent |
|---|---|
| kind | GKE, OpenShift, AKS, EKS or enterprise Kubernetes |
| Helm chart | Standardized application deployment package |
| NodePort with kind port mapping | Ingress, API gateway, service mesh or load balancer |
| Local Keycloak | Keycloak HA cluster |
| host.docker.internal JWKS URL | Internal DNS, service discovery or ingress endpoint |
| Single API replica | Multi-replica deployment with HPA |
| Local image | Container registry such as Artifact Registry, ECR, ACR or Harbor |

## Security Notes

- This is a local lab setup.
- No production secrets are used.
- JWT validation is performed using Keycloak JWKS.
- Sensitive values should be moved to Kubernetes Secrets or Vault integration in the next phase.
- TLS, ingress, network policies and service account hardening should be added for production.
