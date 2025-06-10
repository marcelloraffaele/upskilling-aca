# this demo is for already existing Azure Container Apps environment
# if you need to create a new environment, please refer to https://learn.microsoft.com/en-us/azure/container-apps/tutorial-deploy-first-app-cli?tabs=bash

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

$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"

# Create a container app
az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn
