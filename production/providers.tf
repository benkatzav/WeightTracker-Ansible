# Configure the Azure provider
terraform {
  # The following backend block is used in order to store the Terraform state in Azure Blob Storage
  # Please fill up the requirements and uncomment it in order to use it (use terraform init)
  /*
  backend "azurerm" {
    resource_group_name  = <your resource group in which the storage located>
    storage_account_name = <your storage account name>
    container_name       = <the container name>
    key                  = "terraform.tfstate"
  }
  */
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}