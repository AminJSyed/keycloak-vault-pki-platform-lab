# Security Notes

This repository is a local lab for demonstrating IAM, Keycloak, Vault and PKI engineering concepts.

## Important Notes

- The credentials in this lab are for local testing only.
- Vault runs in dev mode and must not be used as a production configuration.
- Raw secrets, certificates, private keys, Vault JSON output and CRL files are excluded from Git.
- Screenshots and diagrams are sanitized for portfolio use.
- No real client, employer, production or personal secrets are included.

## Production Considerations

A production implementation should include:

- Keycloak high availability
- External managed database
- TLS everywhere
- Vault HA with Raft storage
- KMS or HSM auto-unseal
- Least privilege Vault policies
- Short-lived certificates
- Automated certificate renewal and revocation
- Monitoring, alerting and audit logs
- Secure backup and disaster recovery
