terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.107.0"
    }
  }
  required_version = ">= 1.8.4"
  backend "azurerm" {
    resource_group_name = "manual"
    storage_account_name = "manualstorage"
    container_name = "terraformstorage"
    key = "ntier"
    
  }
}

provider "azurerm" {
  features {

  }

}