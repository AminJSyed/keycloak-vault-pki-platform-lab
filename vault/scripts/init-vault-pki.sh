#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="http://localhost:8200"
export VAULT_TOKEN="root"

mkdir -p evidence

VAULT_CMD="docker compose exec -T -e VAULT_ADDR=http://127.0.0.1:8200 -e VAULT_TOKEN=root vault vault"

echo "Checking Vault status..."
curl -s "$VAULT_ADDR/v1/sys/health" | python3 -m json.tool

echo "Enabling KV v2 secrets engine..."
$VAULT_CMD secrets enable -path=secret kv-v2 >/dev/null 2>&1 || true

echo "Writing demo application secret..."
$VAULT_CMD kv put secret/iam-lab/backend \
  db_username="iam_app" \
  db_password="change-me-in-real-life" \
  api_key="demo-api-key-only-for-local-lab"

echo "Reading demo application secret as evidence..."
$VAULT_CMD kv get secret/iam-lab/backend > evidence/vault-kv-secret-evidence.txt

echo "Enabling PKI secrets engine..."
$VAULT_CMD secrets enable pki >/dev/null 2>&1 || true

echo "Tuning PKI max lease TTL..."
$VAULT_CMD secrets tune -max-lease-ttl=87600h pki

echo "Generating internal root CA..."
$VAULT_CMD write -field=certificate pki/root/generate/internal \
  common_name="iam-lab.local Root CA" \
  ttl=87600h > evidence/iam-lab-root-ca.crt

echo "Configuring issuing certificate and CRL URLs..."
$VAULT_CMD write pki/config/urls \
  issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
  crl_distribution_points="$VAULT_ADDR/v1/pki/crl"

echo "Creating PKI role for iam-lab.local..."
$VAULT_CMD write pki/roles/iam-lab-dot-local \
  allowed_domains="iam-lab.local" \
  allow_subdomains=true \
  max_ttl="72h"

echo "Issuing short-lived certificate..."
$VAULT_CMD write -format=json pki/issue/iam-lab-dot-local \
  common_name="api.iam-lab.local" \
  ttl="24h" > evidence/vault-issued-certificate.json

SERIAL=$(python3 - <<'PY'
import json
with open("evidence/vault-issued-certificate.json") as f:
    data = json.load(f)
print(data["data"]["serial_number"])
PY
)

echo "Issued certificate serial number: $SERIAL"
echo "$SERIAL" > evidence/vault-issued-certificate-serial.txt

echo "Revoking issued certificate..."
$VAULT_CMD write pki/revoke serial_number="$SERIAL" > evidence/vault-certificate-revocation.txt

echo "Fetching CRL evidence..."
curl -s "$VAULT_ADDR/v1/pki/crl" -o evidence/iam-lab-crl.pem

echo "Vault secrets and PKI setup completed."
echo ""
echo "Evidence generated:"
echo "  evidence/vault-kv-secret-evidence.txt"
echo "  evidence/iam-lab-root-ca.crt"
echo "  evidence/vault-issued-certificate.json"
echo "  evidence/vault-issued-certificate-serial.txt"
echo "  evidence/vault-certificate-revocation.txt"
echo "  evidence/iam-lab-crl.pem"
