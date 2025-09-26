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
#$APPLICATION_NAME="<your-application-name>"

#$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"
#
## Create a container app
#az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
#    --image $DEFAULT_IMAGE `
#    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn

# Show details of a container app
az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o yaml > containerapp-show.yaml
# logs
az containerapp logs show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --follow
#revision list
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP