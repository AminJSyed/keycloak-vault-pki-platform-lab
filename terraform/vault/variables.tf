variable "vault_addr" {
  description = "Vault address"
  type        = string
  default     = "http://localhost:8200"
}

variable "vault_token" {
  description = "Vault token for local lab only"
  type        = string
  sensitive   = true
  default     = "root"
}
