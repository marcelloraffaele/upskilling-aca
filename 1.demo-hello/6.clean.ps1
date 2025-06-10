# # https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest
$RESOURCE_GROUP="apim-demo-rg"
$APPLICATION_NAME="hello"

az containerapp delete -g MyResourceGroup -n MyContainerapp --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP

