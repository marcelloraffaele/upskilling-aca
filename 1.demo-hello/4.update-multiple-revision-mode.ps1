# # https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest

# init vars from .env
.\0.init-variables.ps1
#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#$APPLICATION_NAME="<your-application-name>"

$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"
$GREEN_IMAGE="ghcr.io/marcelloraffaele/hello:green"
$BLUE_IMAGE="ghcr.io/marcelloraffaele/hello:blue"

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

#set the revision mode
az containerapp revision set-mode --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --mode multiple

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $DEFAULT_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table

# wait

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $BLUE_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

az containerapp revision deactivate --name $APPLICATION_NAME --revision "hello--0000003" --resource-group $RESOURCE_GROUP