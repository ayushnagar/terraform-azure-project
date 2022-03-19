#create resource group 
az group create --location centralus --name rg-terraform-eg

#create storage account
az storage account create --name terraformstore19032022 --resource-group rg-terraform-eg --location centralus --sku Standard_LRS

#create container
az storage container create --name terraformcont --account-name terraformstore19032022

#enable versioning of storage account
az storage account blob-service-properties update --account-name terraformstore19032022 --enable-change-feed --enable-versioning true

