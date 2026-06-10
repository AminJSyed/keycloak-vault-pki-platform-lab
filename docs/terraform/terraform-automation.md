# Terraform Automation

This project includes Terraform examples for managing Keycloak and Vault configuration as code.

## Keycloak Automation

Terraform manages:

- Realm
- OIDC client
- Realm roles

Terraform folder:

- terraform/keycloak

Terraform-managed realm:

- iam-lab-tf

## Vault Automation

Terraform manages:

- KV v2 secrets engine
- Demo backend secret
- PKI secrets engine
- Internal root CA
- PKI URLs
- PKI role

Terraform folder:

- terraform/vault

Terraform-managed Vault paths:

- tf-secret/
- tf-pki/

## Why separate Terraform resources are used

The Terraform resources are intentionally created with separate names and paths from the script-created lab resources.

This avoids conflicts and keeps the project safe for repeated testing.

## Production Considerations

In production, this design should be improved with:

- Remote encrypted Terraform state
- Strict access control to state files
- Service account authentication
- Least privilege Keycloak admin permissions
- Vault AppRole, Kubernetes auth or OIDC auth instead of root token
- Separate environments for dev, test and production
- CI/CD approval gates
- Policy-as-code checks before apply
