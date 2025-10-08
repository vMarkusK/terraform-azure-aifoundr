variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cognitive_account_name" {
  type = string
}

variable "cosmosdb_account_name" {
  type = string
}

variable "storage_account_name" {
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
