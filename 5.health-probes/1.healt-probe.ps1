# init vars from .env
$ENV_FILE = "..\.env"
Get-Content $ENV_FILE | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        $name = $matches[1].Trim('"')
        $value = $matches[2].Trim('"')
        Set-Variable -Name $name -Value $value -Scope Global
        Write-Host "$name = $value"
    }
}

#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
$APPLICATION_NAME="usecase2"

$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:health-probe"
#
# Create a container app
az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn

#export the config
az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --output yaml > usecase2-export.yaml

az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --yaml usecase2.yaml 

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

az containerapp show -n $APPLICATION_NAME -g $RESOURCE_GROUP

#clean up
az containerapp delete --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -y