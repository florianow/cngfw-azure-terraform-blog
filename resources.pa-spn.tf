resource "azurerm_role_definition" "buildingblock_plan" {
  name        = "${var.service_principal_name}-panorama"
  description = "the role definition is for connecting panorma to the ngfw"
  scope       = var.scope

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
      "Microsoft.Network/*",
      "Microsoft.Compute/*",
      "Microsoft.Storage/*",
      "Microsoft.Insights/*"
    ]
  }
}

resource "azurerm_role_assignment" "palo_alto" {
  role_definition_id = azurerm_role_definition.buildingblock_plan.role_definition_resource_id
  principal_id       = azuread_service_principal.spn_paloalto.object_id
  scope              = var.scope
}

resource "azuread_application" "spn_paloalto" {
  display_name = var.service_principal_name
  description  = "This SPN is used for connecting  paloalto panorama"
}

resource "azuread_service_principal" "spn_paloalto" {
  client_id                    = azuread_application.spn_paloalto.client_id
  app_role_assignment_required = false
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

# allow reading groups and users
resource "azuread_app_role_assignment" "spn_paloalto-directory" {
  app_role_id        = data.azuread_service_principal.msgraph.app_role_ids["Directory.Read.All"]
  resource_object_id = data.azuread_service_principal.msgraph.object_id

  principal_object_id = azuread_service_principal.spn_paloalto.object_id
}

# note this rotation technique requires the terraform to be run regularly
resource "time_rotating" "key_rotation" {
  rotation_days = 365
}

resource "azuread_service_principal_password" "spn_paloalto" {
  service_principal_id = azuread_service_principal.spn_paloalto.id
  rotate_when_changed = {
    rotation = time_rotating.key_rotation.id
  }
}