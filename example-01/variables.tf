variable "location"{
    type = string
    description = "Azure location for network components"
    default = "centralus"
}

variable "application" {
    type = string
    default = "terraApp"
}

variable "vnet_address_space" {
    type = list(any)
    description = "Address space for virtual network"
    default = ["10.0.0.0/16", "10.1.0.0/16"]
}

variable "snet_address_space" {
    type = list(any)
    description = "Address space for subnet network"
    default = [ "10.0.0.0/24" ]
}

variable "admin_username" {
    type = string
    description = "Admin Username value"
}

variable "admin_password" {
    type = string
    description = "Admin Password"
    sensitive = true
}

variable "storage_account_type" {
    type = map
    description = "Disk type Premium in Primary location Standard in DR location"

    default = {
        westus2 = "Premium_LRS"
        centralus = "Standard_LRS"
    }
} 

variable "vm_size" {
    type = string
    description = "Size of VM"
    default = "Standard_B1s"
}

variable "os" {
    description = "OS image to deplay"
    type = object({
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2016-Datacenter"
        version   = "latest"
    })
}



