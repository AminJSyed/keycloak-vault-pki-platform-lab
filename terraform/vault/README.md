# Terraform Vault Automation

This folder demonstrates Vault configuration as code.

## Resources Managed

- KV v2 secrets engine
- Demo backend secret
- PKI secrets engine
- Internal root CA
- PKI issuing and CRL URLs
- PKI role for short-lived certificate issuance

## Terraform-Managed Paths

Terraform creates separate paths:

- tf-secret/
- tf-pki/

This avoids changing the script-created paths:

- secret/
- pki/

## Run

terraform init
terraform plan
terraform apply

## Security Notes

This is a local lab only.

Terraform state can contain sensitive values, especially Vault secrets and certificate material. In production, Terraform state must be stored securely using encrypted remote state with strict access control.
