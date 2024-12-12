provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id                  = include.platform.locals.platform.azure.aadTenantId
  storage_use_azuread        = true


  # recommended: use a separate subscription for networking
  subscription_id = "the-id-of-your-networking-subscription"
}

provider "azuread" {
  tenant_id = include.platform.locals.platform.azure.aadTenantId
}
