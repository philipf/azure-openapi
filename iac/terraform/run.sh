tenantId=<Your AAD Tenant ID>
subscriptionId=<Your Azure Subscription ID>
location=australiaeast
resourceGroup=rg-shared-poc

# Log into to AAD tenant
az login -t $tenantId

# Switch to the correct subscription
az account set --subscription $subscriptionId

terraform init
terraform plan -out tfplan 
terraform apply tfplan