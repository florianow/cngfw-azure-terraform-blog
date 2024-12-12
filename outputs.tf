output "hub_subscription" {
  value       = data.azurerm_subscription.current.subscription_id
  description = "Subscription of hub vnet"
}

output "hub_location" {
  value       = azurerm_virtual_hub.hub.location
  description = "Location of hub vnet"
}

output "hub_rg" {
  value       = azurerm_resource_group.hub_resource_group.name
  description = "Hub Resource Group name"
}

output "hub_vnet" {
  value       = azurerm_virtual_network.hub_network.name
  description = "Hub VNet name"
}

output "hub_vnet_id" {
  value       = azurerm_virtual_network.hub_network.id
  description = "Hub VNet id"
}

output "firewall_name" {
  value       = azurerm_palo_alto_next_generation_firewall_virtual_hub_local_rulestack.cngfw.name
  description = "firewall name"
}

output "network_admins_azuread_group_id" {
  value = azuread_group.network_admins.object_id
}

output "principal_id" {
  value = azuread_service_principal.spn_paloalto.object_id
}

output "client_id" {
  value = azuread_service_principal.spn_paloalto.client_id
}

output "client_secret" {
  value     = azuread_service_principal_password.spn_paloalto.value
  sensitive = true
}
