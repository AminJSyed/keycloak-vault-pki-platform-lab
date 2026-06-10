# Terraform Keycloak Automation

This folder demonstrates Keycloak configuration as code.

## Resources Managed

- Keycloak realm
- OIDC client
- Realm roles

## Lab Realm

Terraform creates a separate realm:

- iam-lab-tf

This avoids changing the script-created realm:

- iam-lab

## Run

terraform init
terraform plan
terraform apply

## Notes

This is a local lab setup. Credentials are default demo credentials and must not be used in production.

A production implementation should use:

- Service account authentication
- Secure secret storage
- Remote Terraform state
- State encryption
- Least privilege Keycloak admin permissions
