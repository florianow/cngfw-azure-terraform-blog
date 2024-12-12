resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region
}

resource "azurerm_public_ip" "cngfw-pip" {
  name                = "cngfw-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_wan" "vwan" {
  name                = var.vwan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
}

resource "azurerm_virtual_hub" "hub" {
  name                = var.hub_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = var.address_space
}

resource "azurerm_palo_alto_virtual_network_appliance" "nva" {
  name           = var.pa_ngfw_name
  virtual_hub_id = azurerm_virtual_hub.hub.id
}

resource "azurerm_palo_alto_local_rulestack" "lrs" {
  name                  = "terraform-lrs"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  anti_spyware_profile  = "BestPractice"
  anti_virus_profile    = "BestPractice"
  file_blocking_profile = "BestPractice"
  vulnerability_profile = "BestPractice"
  url_filtering_profile = "BestPractice"
}

resource "azurerm_palo_alto_next_generation_firewall_virtual_hub_local_rulestack" "cngfw" {
  name                = var.pa_ngfw_name
  resource_group_name = azurerm_resource_group.rg.name
  rulestack_id        = azurerm_palo_alto_local_rulestack.lrs.id

  network_profile {
    public_ip_address_ids        = [azurerm_public_ip.cngfw-pip.id]
    virtual_hub_id               = azurerm_virtual_hub.hub.id
    network_virtual_appliance_id = azurerm_palo_alto_virtual_network_appliance.nva.id
  }
}

resource "azurerm_virtual_hub_routing_intent" "routing-intent" {
  name           = "routing-intent"
  virtual_hub_id = azurerm_virtual_hub.hub.id

  routing_policy {
    name         = "InternetTrafficPolicy"
    destinations = ["Internet"]
    next_hop     = azurerm_palo_alto_virtual_network_appliance.nva.id
  }

  routing_policy {
    name         = "PrivateTrafficPolicy"
    destinations = ["PrivateTraffic"]
    next_hop     = azurerm_palo_alto_virtual_network_appliance.nva.id
  }
  depends_on = [azurerm_palo_alto_next_generation_firewall_virtual_hub_local_rulestack.cngfw]
}
