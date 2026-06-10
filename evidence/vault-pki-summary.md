# Vault Secrets and PKI Evidence Summary

This lab validates HashiCorp Vault KV secrets management and PKI certificate lifecycle operations.

## Vault Status

Vault was started successfully in local dev mode.

- Initialized: true
- Sealed: false
- Version: 1.21.3

## KV Secrets Engine

The KV v2 secrets engine was enabled at: secret/

A demo backend application secret was written to: secret/iam-lab/backend

Raw secret values are intentionally not committed to GitHub.

## PKI Secrets Engine

The PKI secrets engine was enabled at: pki/

PKI max lease TTL was configured as: 87600h

## Root CA

An internal root CA was generated: iam-lab.local Root CA

## Issuing and CRL URLs

Issuing Certificate URL: http://localhost:8200/v1/pki/ca

CRL Distribution Point: http://localhost:8200/v1/pki/crl

## PKI Role

A PKI role was created for: iam-lab.local

Role name: iam-lab-dot-local

## Certificate Issuance

A short-lived certificate was issued for: api.iam-lab.local

Certificate TTL: 24h

Certificate serial number: 7c:8a:2b:60:37:05:c3:cc:ea:50:da:b3:f6:81:14:8e:ba:0c:69:25

Private keys and raw certificate payloads are intentionally not committed.

## Certificate Revocation

The issued certificate was revoked using its serial number.

## CRL Evidence

A CRL file was fetched from Vault PKI to validate the revocation lifecycle flow.

## Skills Demonstrated

- HashiCorp Vault local deployment
- KV v2 secrets engine
- Vault token-based administration
- PKI secrets engine
- Internal CA generation
- Certificate role configuration
- Short-lived certificate issuance
- Certificate revocation
- CRL endpoint usage
- Secure evidence handling for GitHub
