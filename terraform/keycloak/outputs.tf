output "realm_name" {
  value       = keycloak_realm.iam_lab_tf.realm
  description = "Terraform-managed Keycloak realm"
}

output "client_id" {
  value       = keycloak_openid_client.platform_api.client_id
  description = "Terraform-managed Keycloak OIDC client"
}

output "roles" {
  value = [
    keycloak_role.platform_engineer.name,
    keycloak_role.security_engineer.name
  ]
  description = "Terraform-managed realm roles"
}
