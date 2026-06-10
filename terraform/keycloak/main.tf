terraform {
  required_version = ">= 1.6.0"

  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = ">= 5.0.0"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = var.keycloak_admin_user
  password  = var.keycloak_admin_password
  url       = var.keycloak_url
}

resource "keycloak_realm" "iam_lab_tf" {
  realm        = var.realm_name
  enabled      = true
  display_name = "IAM Platform Lab - Terraform Managed"
}

resource "keycloak_openid_client" "platform_api" {
  realm_id                     = keycloak_realm.iam_lab_tf.id
  client_id                    = "platform-api"
  name                         = "Platform API"
  enabled                      = true
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true

  valid_redirect_uris = [
    "http://localhost:8100/*"
  ]

  web_origins = [
    "+"
  ]
}

resource "keycloak_role" "platform_engineer" {
  realm_id    = keycloak_realm.iam_lab_tf.id
  name        = "platform-engineer"
  description = "Platform engineer role managed by Terraform"
}

resource "keycloak_role" "security_engineer" {
  realm_id    = keycloak_realm.iam_lab_tf.id
  name        = "security-engineer"
  description = "Security engineer role managed by Terraform"
}
