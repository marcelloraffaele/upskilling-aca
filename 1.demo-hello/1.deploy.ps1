# this demo is for already existing Azure Container Apps environment
# if you need to create a new environment, please refer to https://learn.microsoft.com/en-us/azure/container-apps/tutorial-deploy-first-app-cli?tabs=bash

# init vars from .env
.\0.init-variables.ps1
#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#$APPLICATION_NAME="<your-application-name>"

$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"

# Create a container app
az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn


az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o yaml > export.yaml