# ArgoCD GitOps Evidence Summary

This lab validates GitOps-style deployment using ArgoCD.

## ArgoCD Runtime

ArgoCD was installed inside the local kind Kubernetes cluster.

- Namespace: argocd
- UI exposed at: http://localhost:8102
- Access method: NodePort through kind port mapping

## GitOps Application

ArgoCD application created:

- Application name: platform-api
- Source repo: https://github.com/AminJSyed/keycloak-vault-pki-platform-lab.git
- Source path: helm/platform-api
- Target namespace: iam-platform
- Sync policy: automated sync with prune and self-heal

## Platform API Deployment

The platform API is deployed from the Helm chart stored in GitHub.

The API is exposed at:

- http://localhost:8101

## Validation

ArgoCD application status:

- Sync status: Synced
- Health status: Healthy

The Kubernetes-hosted API successfully validated a Keycloak-issued Bearer token and returned protected user and role claims.

Validated concepts:

- GitHub as source of truth
- ArgoCD application sync
- Helm-based deployment
- Kubernetes-hosted protected API
- Keycloak JWT validation from a GitOps-managed workload
- Drift correction through self-heal

## Skills Demonstrated

- ArgoCD installation
- GitOps application definition
- Helm deployment through ArgoCD
- Kubernetes namespace management
- Automated sync and self-healing
- GitOps production mapping
