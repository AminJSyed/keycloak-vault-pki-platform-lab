# Vault Secrets and PKI Flow

This lab demonstrates HashiCorp Vault secrets management and PKI certificate lifecycle operations.

## What this setup does

1. Starts Vault in local dev mode.
2. Enables KV v2 secrets engine.
3. Stores a demo backend application secret.
4. Enables Vault PKI secrets engine.
5. Generates an internal root CA.
6. Configures issuing certificate and CRL URLs.
7. Creates a PKI role for iam-lab.local.
8. Issues a short-lived certificate for api.iam-lab.local.
9. Revokes the issued certificate.
10. Downloads CRL evidence.

## Why this is useful

In real cloud-native platforms, Vault can be used to manage:

- Application secrets
- Database credentials
- API keys
- Internal CA certificates
- Short-lived service certificates
- Certificate revocation
- PKI lifecycle automation

## Role relevance

This maps directly to IAM, secrets, and PKI engineering work involving:

- HashiCorp Vault
- PKI secrets engine
- Certificate issuance
- Certificate revocation
- CRL-based lifecycle evidence
- Secure platform engineering
