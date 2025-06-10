# # https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest
$RESOURCE_GROUP="apim-demo-rg"
$APPLICATION_NAME="hello"
$GREEN_IMAGE="ghcr.io/marcelloraffaele/hello:green"
$BLUE_IMAGE="ghcr.io/marcelloraffaele/hello:blue"

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $GREEN_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table

# wait

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $BLUE_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

