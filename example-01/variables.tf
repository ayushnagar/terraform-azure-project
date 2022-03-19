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





