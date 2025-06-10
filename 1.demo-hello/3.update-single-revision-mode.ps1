# # https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest
## init vars from .env
Get-Content .env | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        $name = $matches[1].Trim('"')
        $value = $matches[2].Trim('"')
        Set-Variable -Name $name -Value $value -Scope Global
        Write-Host "$name = $value"
    }
}
#or
# init this vars
#RESOURCE_GROUP="<your-resource-group>"
#CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#APPLICATION_NAME="<your-application-name>"

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
