terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.2.0"
}
# Create VNet
resource "azurerm_virtual_network" "my_vnet" {
  name                = "lopes-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US" 
  resource_group_name = "lopes-resource-group"

  tags = {
    environment = "production"
  }
}
