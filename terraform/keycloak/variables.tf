variable "keycloak_url" {
  description = "Keycloak base URL"
  type        = string
  default     = "http://localhost:8180"
}

variable "keycloak_admin_user" {
  description = "Keycloak admin username"
  type        = string
  default     = "admin"
}

variable "keycloak_admin_password" {
  description = "Keycloak admin password for local lab only"
  type        = string
  sensitive   = true
  default     = "admin"
}

variable "realm_name" {
  description = "Terraform-managed Keycloak realm name"
  type        = string
  default     = "iam-lab-tf"
}
