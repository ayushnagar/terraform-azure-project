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

resource "azurerm_public_ip" "public_ip" {
  name = "publicIpConfig"
  resource_group_name = azurerm_resource_group.rgterraform_eg.name
  location = azurerm_resource_group.rgterraform_eg.location
  allocation_method = "Static"
}

resource "azurerm_network_interface" "nic" {
  name = "network-01-${var.application}"
  resource_group_name = azurerm_resource_group.rgterraform_eg.name
  location = azurerm_resource_group.rgterraform_eg.location

  ip_configuration {
    name = "nicfg-${var.application}"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
  
}

resource "azurerm_windows_virtual_machine" "vm-terraform" {
  name = "vm-terraform"
  location = azurerm_resource_group.rgterraform_eg.location
  resource_group_name = azurerm_resource_group.rgterraform_eg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }
}