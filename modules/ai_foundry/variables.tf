// Variables for inlined ai_foundry module
// These mirror the external module inputs used by the root module so
// switching to the local module is seamless.

variable "enable_telemetry" {
  type    = bool
  default = false
}

variable "base_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_resource_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "ai_foundry" {
  type    = map(any)
  default = {}
}

variable "ai_model_deployments" {
  type    = map(any)
  default = {}
}

variable "ai_projects" {
  type    = map(any)
  default = {}
}

variable "ai_search_definition" {
  type    = map(any)
  default = {}
}

variable "cosmosdb_definition" {
  type    = map(any)
  default = {}
}

variable "create_byor" {
  type    = bool
  default = true
}

variable "create_private_endpoints" {
  type    = bool
  default = false
}

variable "key_vault_definition" {
  type    = map(any)
  default = {}
}

variable "storage_account_definition" {
  type    = map(any)
  default = {}
}
