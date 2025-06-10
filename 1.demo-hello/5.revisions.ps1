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

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

# get info about the current revision
$REVISION_NAME = "hello--0000004"
az containerapp revision show --name $APPLICATION_NAME --revision $REVISION_NAME --resource-group $RESOURCE_GROUP

#create a new revision using copy
$GREEN_REVISION_SUFFIX="green01"
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --from-revision $REVISION_NAME `
    --image $GREEN_IMAGE `
    --revision-suffix $GREEN_REVISION_SUFFIX
#    --set-env-vars DB_TYPE=local

#create a new revision using copy
$BLUE_REVISION_SUFFIX="blue01"
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --from-revision $REVISION_NAME `
    --image $BLUE_IMAGE `
    --revision-suffix $BLUE_REVISION_SUFFIX


# set traffic weigths
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --revision-weight hello--green01=100 hello--blue01=0


$UNDER_CONSTRUCTION_REVISION_SUFFIX="underconstruction01"
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --from-revision $REVISION_NAME `
    --image $UNDER_CONSTRUCTION_IMAGE `
    --revision-suffix $UNDER_CONSTRUCTION_REVISION_SUFFIX

##
## revision with label
##
az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table

#set the labels
az containerapp revision label add --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --label prod --revision hello--green01
az containerapp revision label add --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --label staging --revision hello--blue01
az containerapp revision label add --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --label under-construction --revision hello--underconstruction01

# promote the staging revision to production
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label-weight staging=100 prod=0 under-construction=0
# swap the labels of the revisions
az containerapp revision label swap -n $APPLICATION_NAME -g $RESOURCE_GROUP `
    --source staging --target prod