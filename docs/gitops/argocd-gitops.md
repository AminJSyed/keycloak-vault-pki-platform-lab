# ArgoCD GitOps Deployment

This phase demonstrates GitOps-based deployment of the protected platform API using ArgoCD.

## What ArgoCD manages

ArgoCD deploys the platform API Helm chart from the GitHub repository.

Source of truth:

- GitHub repository: AminJSyed/keycloak-vault-pki-platform-lab
- Path: helm/platform-api
- Branch: main

ArgoCD application:

- platform-api

Target namespace:

- iam-platform

## Access Model

The lab exposes services without kubectl port-forward.

| Component | Local URL |
|---|---|
| Platform API | http://localhost:8101 |
| ArgoCD UI | http://localhost:8102 |

## GitOps Flow

1. Helm chart is stored in GitHub.
2. ArgoCD watches the GitHub repository.
3. ArgoCD syncs the Helm chart into Kubernetes.
4. Kubernetes runs the protected FastAPI API.
5. The API validates Keycloak-issued JWT tokens.
6. ArgoCD can self-heal if deployed resources drift from Git.

## Validation

The ArgoCD application reached:

- Sync status: Synced
- Health status: Healthy

The protected API successfully validated a Keycloak-issued Bearer token and returned user and role claims.

## Production Mapping

| Lab Component | Production Equivalent |
|---|---|
| ArgoCD local install | Enterprise ArgoCD or OpenShift GitOps |
| GitHub public repo | Enterprise GitHub/GitLab/Bitbucket repo |
| Helm chart path | Application deployment package |
| Automated sync | Controlled promotion with approvals |
| Self-heal | Drift correction |
| kind NodePort | Ingress, API gateway or internal load balancer |

## Security Notes

- This is a local lab setup.
- No production secrets are stored in Git.
- ArgoCD admin password is generated locally by the cluster and must not be committed.
- Production should use SSO, RBAC, project restrictions and private repository access controls.
- Production sync should include approval gates for sensitive environments.
