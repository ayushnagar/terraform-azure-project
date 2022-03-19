terraform {
  required_providers{
      azurerm = {
          source = "hashicorp/azurerm"
          version = "2.40.0"
      }
  }
  backend "azurerm" {
    resource_group_name = "rg-terraform-eg"
    storage_account_name = "terraformstore19032022"
    container_name = "terraformcont"
    key = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rgterraform_eg" {
    name     = "rg-${var.application}"
    location = var.location
    tags      = {
      Environment = "terraexample"
    }
}

resource "azurerm_virtual_network" "virtualterraform"{
  name = "vnet-${var.application}"
  location = azurerm_resource_group.rgterraform_eg.location
  resource_group_name = azurerm_resource_group.rgterraform_eg.name
  address_space = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
  name = "subnet-${var.application}"
  resource_group_name = azurerm_resource_group.rgterraform_eg.name
  virtual_network_name = azurerm_virtual_network.virtualterraform.name
  address_prefixes = var.snet_address_space
}

module "server" {
    source = "./modules/terraform-azure-server"
    subnet_id = azurerm_subnet.subnet.id
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location

    servername = "server1"
    vm_size = "Standard_B1s"
    admin_username = "terraadmin"
    admin_password = "P@ssw0rdP@ssw0rd"
    os = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2016-Datacenter"
        version   = "latest"
    }
}



