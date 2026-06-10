#!/usr/bin/env bash
set -euo pipefail

curl -s \
  -X POST "http://localhost:8180/realms/iam-lab/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password" \
  -d "client_id=iam-lab-cli" \
  -d "username=amin" \
  -d "password=Password123!" | python3 -c "import sys, json; print(json.load(sys.stdin)['access_token'])"
