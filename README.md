[![Open in Dev Containers](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/philipf/azure-openapi)

# azure-openapi

## Summary
This repository demonstrates how an "API First" development approach can be implemented using the OpenAPI Specification and Azure API Management and deployed either Bicep or Terraform

It also includes basic examples of generating server and client-side code.

## Installation 

The easiest to run it as DevContainer in VS Code or Github's Codespaces.  This includes all the required tooling such Azure CLI, Bicep, Terraform and VS Code extensions to work with YAML and OpenAPI.

Otherwise, clone this repository locally and install the following prerequisites:

- Azure API subscription
- Azure API Managment instance 
- Azure CLI
- Bicep (optional if using Terraform)
- Terraform (optional if using Bicep)
- VS Code extensions as needed


## Run samples

Deploy to APIM using Bicep
```bash
cd iac/bicep/
./run.sh
```

Deploy to APIM using Terraform
```bash
cd iac/terraform/
./run.sh
```

Generate C# Azure Function server
```bash
cd tools/gen-server.sh
```

Generate C# Angular client
```bash
cd tools/gen-clients.sh
```
