terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.61.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "03817a80-26ba-454c-abd9-ecfc35cb5cc5"
}

