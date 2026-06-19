# Kubernetes Security Hardening Evidence Summary

This phase validates production-style Kubernetes workload hardening for the platform API.

## Workload

- Namespace: iam-platform
- Deployment: platform-api
- Managed by: ArgoCD
- Deployment method: Helm chart from GitHub

## Pod Security Context

The platform API pod is configured with:

- runAsNonRoot: true
- runAsUser: 10001
- runAsGroup: 10001
- fsGroup: 10001
- seccompProfile: RuntimeDefault

## Container Security Context

The platform API container is configured with:

- allowPrivilegeEscalation: false
- readOnlyRootFilesystem: true
- Linux capabilities dropped: ALL

## Validation

A new ReplicaSet was created after ArgoCD refreshed from GitHub:

- platform-api-5dcdcc6545

The previous ReplicaSet was scaled down:

- platform-api-89fdd4d66

The deployment security context was confirmed using kubectl jsonpath commands.

The protected API continued to work after hardening and successfully validated a Keycloak-issued Bearer token.

## Production Relevance

This hardening reduces container runtime risk by enforcing:

- Non-root execution
- Reduced Linux kernel attack surface
- No privilege escalation
- Immutable container filesystem
- RuntimeDefault seccomp profile
- GitOps-managed security configuration

## Skills Demonstrated

- Kubernetes pod security hardening
- Helm-based security configuration
- ArgoCD GitOps refresh and rollout
- Secure workload deployment
- Validation of application functionality after security changes
