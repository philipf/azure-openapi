tenantId=<Your AAD Tenant ID>
subscriptionId=<Your Azure Subscription ID>
location=australiaeast
resourceGroup=rg-shared-poc

# Log into to AAD tenant
az login -t $tenantId

# Switch to the correct subscription
az account set --subscription $subscriptionId

# Create a resource group
az group create --name $resourceGroup --location $location

# Deploy the API
az deployment group create --template-file ./main.bicep \
    --resource-group $resourceGroup \
    --name "api-first" \
    --verbose