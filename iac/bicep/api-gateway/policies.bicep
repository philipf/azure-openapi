@description('The name of the API Management service to which the API should be added')
param apimServiceName string

@description('The path of the API to be created, also known as the API URI suffix')
param apiPath string

// Get a reference to the existing API Management service
resource apiManagementService 'Microsoft.ApiManagement/service@2023-03-01-preview' existing = {
  name: apimServiceName
}

// Get a reference to the newly created API (version), so it can be used to add policies
resource apiDefinition 'Microsoft.ApiManagement/service/apis@2023-03-01-preview' existing = {
    name: apiPath
    parent: apiManagementService
}

// Add All Operations policy to the My Notes API
resource allOperationsPolicy 'Microsoft.ApiManagement/service/apis/policies@2023-03-01-preview' = {
  name: 'policy'
  parent: apiDefinition
  properties: {
    format: 'rawxml'
    value: loadTextContent('./policies/all-operations.xml')
  }
}

// Get a reference to the PUT /note operation, so it can be used to add policies
resource createNoteOperation 'Microsoft.ApiManagement/service/apis/operations@2023-03-01-preview' existing = {
  name: 'CreateNote'
  parent: apiDefinition
}

// A operation specific policies to the PUT /note operation
resource createNotePolicy 'Microsoft.ApiManagement/service/apis/operations/policies@2023-03-01-preview' = {
  name: 'policy'
  parent: createNoteOperation
  properties: {
    format: 'rawxml'
    value: loadTextContent('./policies/create-note.xml')
  }
}
