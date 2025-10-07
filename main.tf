terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  backend "azurerm" {}
  required_version = "~> 1.13.3"
}

provider "azurerm" {
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "core"
  storage_use_azuread             = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
  }
}
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"

  suffix        = [var.usecase]
  unique-length = 5
}

resource "azurerm_resource_group" "this" {
  location = var.location
  name     = module.naming.resource_group.name_unique

  tags = local.tags
}