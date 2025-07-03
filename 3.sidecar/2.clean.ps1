# # https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest

# init vars from .env
.\0.init-variables.ps1
#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#$APPLICATION_NAME="<your-application-name>"

az containerapp delete -g $RESOURCE_GROUP -n $APPLICATION_NAME

