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
$UNDER_CONSTRUCTION_IMAGE="ghcr.io/marcelloraffaele/hello:under-construction"

# check the revision list
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

# update the image to green
az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $GREEN_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

# update the image to under construction
az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $UNDER_CONSTRUCTION_IMAGE

# update the image to blue
az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --image $BLUE_IMAGE

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

# rollback to the previous revision
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --from-revision "hello--0000003" `
    --revision-suffix "rollback" 

# get info about a specific revision
az containerapp revision show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --revision "hello--0000003" -o yaml

