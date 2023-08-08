var apimServiceName = 'apim-devtest-poc' // The name of the API Management service to which the API should be added
var apiPath         = 'mynotes'          // The unique path of the API to be created, also known as the API URI suffix

// Create API, version set and operations from the OpenAPI specification
module createFromOpenApi '../modules/apim/apiFromOpenApi.bicep' = {
    name: 'createFromOpenApi'
    params: {
      apimServiceName: apimServiceName
      apiPath: apiPath
      apiVersion: '1.0'
      apiDisplayName: 'My Notes'
      openApiFileContents: loadTextContent('../../../docs/my-notes-api-v1.0.0.yaml')
  }
}

// Add Policies to the API and Operations as defined from the previous step
module addPolicies 'policies.bicep' = {
  name: 'addPolicies'
  dependsOn: [ createFromOpenApi ]  
  params: {
    apimServiceName: apimServiceName
    apiPath: apiPath
  }
}
