terraform {
  required_version = ">= 1.6.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 5.0.0"
    }
  }
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

resource "vault_mount" "kv" {
  path        = "tf-secret"
  type        = "kv-v2"
  description = "Terraform-managed KV v2 secrets engine for IAM lab"
}

resource "vault_kv_secret_v2" "backend_config" {
  mount = vault_mount.kv.path
  name  = "iam-lab/backend"

  data_json = jsonencode({
    db_username = "iam_tf_app"
    db_password = "demo-password-not-for-production"
    api_key     = "demo-api-key-not-for-production"
  })
}

resource "vault_mount" "pki" {
  path                      = "tf-pki"
  type                      = "pki"
  description               = "Terraform-managed PKI secrets engine for IAM lab"
  default_lease_ttl_seconds = 86400
  max_lease_ttl_seconds     = 315360000
}

resource "vault_pki_secret_backend_root_cert" "root_ca" {
  backend     = vault_mount.pki.path
  type        = "internal"
  common_name = "iam-lab-tf.local Root CA"
  ttl         = "87600h"
}

resource "vault_pki_secret_backend_config_urls" "pki_urls" {
  backend                 = vault_mount.pki.path
  issuing_certificates    = ["${var.vault_addr}/v1/${vault_mount.pki.path}/ca"]
  crl_distribution_points = ["${var.vault_addr}/v1/${vault_mount.pki.path}/crl"]
}

resource "vault_pki_secret_backend_role" "iam_lab_role" {
  backend          = vault_mount.pki.path
  name             = "iam-lab-tf-dot-local"
  allowed_domains  = ["iam-lab-tf.local"]
  allow_subdomains = true
  allow_localhost  = true
  max_ttl          = "72h"
}
