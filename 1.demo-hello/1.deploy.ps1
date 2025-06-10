# this demo is for already existing Azure Container Apps environment
# if you need to create a new environment, please refer to https://learn.microsoft.com/en-us/azure/container-apps/tutorial-deploy-first-app-cli?tabs=bash
$RESOURCE_GROUP="apim-demo-rg"
$CONTAINERAPPS_ENVIRONMENT="demo-public-env"

$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"

# Create a container app
$APPLICATION_NAME="hello"
az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn

