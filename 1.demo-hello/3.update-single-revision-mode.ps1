# # https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest
# init vars from .env
.\0.init-variables.ps1
#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#$APPLICATION_NAME="<your-application-name>"

$GREEN_IMAGE="ghcr.io/marcelloraffaele/hello:green"
$BLUE_IMAGE="ghcr.io/marcelloraffaele/hello:blue"
$UNDER_CONSTRUCTION_IMAGE="ghcr.io/marcelloraffaele/hello:under-construction"

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $GREEN_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table

# wait

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $BLUE_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $UNDER_CONSTRUCTION_IMAGE
