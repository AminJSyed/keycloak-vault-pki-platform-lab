# Terraform Automation Evidence Summary

This lab validates Terraform-based configuration management for Keycloak and HashiCorp Vault.

## Keycloak Terraform Automation

Terraform created a separate Keycloak realm for infrastructure-as-code testing:

- Realm: iam-lab-tf
- OIDC discovery endpoint: http://localhost:8180/realms/iam-lab-tf/.well-known/openid-configuration

The OIDC discovery endpoint returned valid realm metadata including:

- issuer
- authorization_endpoint
- token_endpoint
- userinfo_endpoint
- jwks_uri
- supported grant types
- supported response types

## Vault Terraform Automation

Terraform created separate Vault mounts for infrastructure-as-code testing:

- tf-secret/
- tf-pki/

The Vault secrets list confirmed:

- tf-secret/ as Terraform-managed KV v2 secrets engine
- tf-pki/ as Terraform-managed PKI secrets engine

## Why Separate Terraform Resources Were Used

Terraform resources use separate names from the script-created lab resources.

Script-created resources:

- Keycloak realm: iam-lab
- Vault paths: secret/ and pki/

Terraform-created resources:

- Keycloak realm: iam-lab-tf
- Vault paths: tf-secret/ and tf-pki/

This avoids conflicts and makes the lab safe to rerun.

## Skills Demonstrated

- Terraform provider usage for Keycloak
- Terraform provider usage for Vault
- Keycloak realm automation
- Keycloak OIDC client and role automation
- Vault KV secrets engine automation
- Vault PKI secrets engine automation
- Infrastructure-as-Code for IAM and PKI platforms
- Safe separation between manual/scripted resources and Terraform-managed resources
