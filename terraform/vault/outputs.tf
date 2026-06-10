output "kv_mount_path" {
  value       = vault_mount.kv.path
  description = "Terraform-managed KV secrets engine path"
}

output "pki_mount_path" {
  value       = vault_mount.pki.path
  description = "Terraform-managed PKI secrets engine path"
}

output "pki_role_name" {
  value       = vault_pki_secret_backend_role.iam_lab_role.name
  description = "Terraform-managed PKI role"
}
