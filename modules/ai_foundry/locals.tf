// Local helpers for the inlined ai_foundry module
locals {
  rg_name = split("/", var.resource_group_resource_id)[length(split("/", var.resource_group_resource_id)) - 1]
}
