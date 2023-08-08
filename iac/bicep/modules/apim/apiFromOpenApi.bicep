
@description('Creates an API in an existing API Management service instance by importing an OpenAPI definition.')
param apimServiceName string

@description('''
  Path of the API, for example /myapi. 
  This must be unique within the API Management service instance.
  ''')
param apiPath string

@description('''
  Version of the API, it is recommended to use semantic versioning such as MAJOR.MINOR.PATCH. 
  In APIM the patch part can be used to version revisions of the API, therefore only supply the MAJOR.MINOR part of the version here.
  ''')
param apiVersion string

@description('Display name of the API in APIM')
param apiDisplayName string

@description('''
  OpenAPI file contents which will be imported as an API definition.
  This must be a valid OpenAPI 3.0.x definition.
  The contents of the file must be passed in as a string, for example by using loadTextContent().
''')
param openApiFileContents string

var flattendVersion       = replace(apiVersion, '.', '-')  // Replace dots with dashes in the API version to create a valid API version set name
var apiVersionSetName     = '${apiPath}-${flattendVersion}'
var apiVersionDisplayName = '${apiDisplayName} ${apiVersion}'

// Get a reference to the existing API Management service
resource apiManagementService 'Microsoft.ApiManagement/service@2023-03-01-preview' existing = {
  name: apimServiceName
}

// Add version set for the API
resource apiVersionSet 'Microsoft.ApiManagement/service/apiVersionSets@2023-03-01-preview' = {
  name: apiVersionSetName
  parent: apiManagementService
  properties: {
    displayName: apiDisplayName
    versioningScheme: 'Segment'
  }
}

// Create all the API operations by importing the OpenAPI definition
resource apiDefinition 'Microsoft.ApiManagement/service/apis@2023-03-01-preview' = {
  name: apiPath
  parent: apiManagementService
  
  properties: {
    path: apiPath
    displayName: apiVersionDisplayName
    type: 'http'
    protocols: ['https']
    apiVersionSetId: apiVersionSet.id
    apiVersion: apiVersion
    format: 'openapi'

    // *********************************************//
    // ** This is the key part of the solution   ** //
    value: openApiFileContents                      // Unfortunately loadTextContent() doesn't allow parameters and this must be passed in as a string
    // *********************************************//
  }
}

output apiManagementServiceId string = apiManagementService.id
output apiVersionSetId string = apiVersionSet.id
output apiDefinitionId string = apiDefinition.id
output apiDefinitionName string = apiDefinition.name
