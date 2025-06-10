# revisions
# https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest

# init vars from .env
.\0.init-variables.ps1
#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#$APPLICATION_NAME="<your-application-name>"

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table
#az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --all -o table

$REVISION_NAME = "todo-app--0000005"
az containerapp revision show --name $APPLICATION_NAME --revision $REVISION_NAME --resource-group $RESOURCE_GROUP


$REVISION_SUFFIX="0000005"
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --from-revision $REVISION_NAME `
    --revision-suffix $REVISION_SUFFIX `
    --set-env-vars DB_TYPE=local


az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table

$NEW_REVISION_NAME = "todo-app--" + $REVISION_SUFFIX

az containerapp revision label add --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --label db-local --revision $NEW_REVISION_NAME


# change the weight of the traffic to the new revision
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label-weight staging=30 prod=70


# promote the staging revision to production
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label-weight staging=100 prod=0
# swap the labels of the revisions
az containerapp revision label swap -n $APPLICATION_NAME -g $RESOURCE_GROUP `
    --source staging --target prod


#az containerapp revision activate --name $APPLICATION_NAME --revision $NEW_REVISION_NAME --resource-group $RESOURCE_GROUP

#az containerapp revision restart -n $APPLICATION_NAME -g $RESOURCE_GROUP --revision $NEW_REVISION_NAME

#az containerapp revision deactivate --name $APPLICATION_NAME --revision "todo-app--0000001" --resource-group $RESOURCE_GROUP
