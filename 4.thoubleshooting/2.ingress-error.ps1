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

$NEW_APP_NAME="usecase1"
$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"

# Create a container app
az containerapp create --name $NEW_APP_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 9000 --ingress external --query properties.configuration.ingress.fqdn

az containerapp delete -g $RESOURCE_GROUP -n $NEW_APP_NAME