variable "servername" {
  type = string
  description = "Server Name"
  default = "servername"
}

variable "location"{
    type = string
    description = "Azure location for network components"
    default = "centralus"
}

var "resource_group_name"{
    type = string
    description = "Resource Group Name"
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
        publisher = string
        offer     = string
        sku       = string
        version   = string
    })
}

variable "subnet_id" {
    type = string
    description = "ID of the subnet to assign to the Network Interface resource"
}