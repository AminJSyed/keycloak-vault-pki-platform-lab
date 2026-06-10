#!/usr/bin/env bash
set -euo pipefail

echo "Waiting for Keycloak to be ready on http://localhost:8180 ..."
until curl -s http://localhost:8180/realms/master >/dev/null; do
  sleep 3
done

echo "Configuring Keycloak admin CLI..."
docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user admin \
  --password admin

echo "Checking realm iam-lab..."
if docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh get realms/iam-lab >/dev/null 2>&1; then
  echo "Realm iam-lab already exists"
else
  echo "Creating realm iam-lab..."
  docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh create realms \
    -s realm=iam-lab \
    -s enabled=true \
    -s displayName="IAM Platform Lab"
fi

echo "Checking client iam-lab-cli..."
CLIENT_EXISTS=$(docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh get clients -r iam-lab -q clientId=iam-lab-cli --fields clientId 2>/dev/null || true)

if echo "$CLIENT_EXISTS" | grep -q "iam-lab-cli"; then
  echo "Client iam-lab-cli already exists"
else
  echo "Creating public client iam-lab-cli..."
  docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh create clients -r iam-lab \
    -s clientId=iam-lab-cli \
    -s enabled=true \
    -s publicClient=true \
    -s directAccessGrantsEnabled=true \
    -s standardFlowEnabled=true \
    -s redirectUris='["http://localhost:8100/*","http://localhost:8180/*"]' \
    -s webOrigins='["*"]'
fi

echo "Checking realm role platform-engineer..."
if docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh get roles/platform-engineer -r iam-lab >/dev/null 2>&1; then
  echo "Role platform-engineer already exists"
else
  echo "Creating realm role platform-engineer..."
  docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh create roles -r iam-lab \
    -s name=platform-engineer \
    -s description="Platform engineer role for IAM lab"
fi

echo "Checking user amin..."
USER_EXISTS=$(docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh get users -r iam-lab -q username=amin --fields username 2>/dev/null || true)

if echo "$USER_EXISTS" | grep -q "amin"; then
  echo "User amin already exists"
else
  echo "Creating test user amin..."
  docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh create users -r iam-lab \
    -s username=amin \
    -s enabled=true \
    -s email=amin@example.com \
    -s firstName=Amin \
    -s lastName=Syed
fi

USER_ID=$(docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh get users -r iam-lab -q username=amin --fields id --format csv | tail -n 1 | tr -d '"')

echo "Setting password for user amin..."
docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh set-password -r iam-lab \
  --userid "$USER_ID" \
  --new-password 'Password123!'

echo "Assigning platform-engineer role to amin..."
docker compose exec -T keycloak /opt/keycloak/bin/kcadm.sh add-roles -r iam-lab \
  --uusername amin \
  --rolename platform-engineer || true

echo "Keycloak setup completed."
echo "Realm: iam-lab"
echo "Client: iam-lab-cli"
echo "User: amin"
echo "Password: Password123!"
