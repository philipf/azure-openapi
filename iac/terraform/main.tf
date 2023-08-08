locals {
  apim_service_name = "apim-devtest-poc"
  api_path          = "mynotes"
  rg_shared         = "rg-shared-poc"
  version           = "1.0"
}

data "azurerm_resource_group" "rg_shared" {
  name = local.rg_shared
}

data "azurerm_api_management" "apim" {
  name                = local.apim_service_name
  resource_group_name = data.azurerm_resource_group.rg_shared.name
}

resource "azurerm_api_management_api_version_set" "version_set_mynotes" {
  name                = "mynotes_${replace(local.version, ".", "_")}"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = "My Notes"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "api_v1_0" {
  name                = local.api_path
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = "My Notes v${local.version}"
  path                = local.api_path
  version_set_id      = azurerm_api_management_api_version_set.version_set_mynotes.id
  version             = local.version
  revision            = 0
  protocols           = ["https"]

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/../../docs/my-notes-api-v1.0.0.yaml")
  }
}

resource "azurerm_api_management_api_policy" "policy_api_v1_0" {
  api_name            = azurerm_api_management_api.api_v1_0.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  xml_content         = file("all-operations.xml")
}

resource "azurerm_api_management_api_operation_policy" "policy_create_note" {
  api_name            = azurerm_api_management_api.api_v1_0.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  operation_id        = "CreateNote"
  xml_content         = file("create-note.xml")
}