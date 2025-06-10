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

az containerapp delete -g $RESOURCE_GROUP -n $APPLICATION_NAME --resource-group $RESOURCE_GROUP

