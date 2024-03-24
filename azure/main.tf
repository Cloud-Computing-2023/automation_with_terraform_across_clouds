terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.2.0"
}
provider "azurerm" {
features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
}

resource "azurerm_resource_group" "my_resource_group" {
  name     = "lopes-resource-group"
  location = "East US"
  tags = {
    environment = "production"
  }
}
# Create VNet
resource "azurerm_virtual_network" "my_vnet" {
  name = "lopes-vnet"
  address_space= ["10.0.0.0/16"]
  location= azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  tags = {
    environment = "production"
  }
}
