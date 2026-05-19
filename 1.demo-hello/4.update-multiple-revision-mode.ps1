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

$APPLICATION_NAME="hello-multirevision"

# Create a container app
az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn

    #set the revision mode
az containerapp revision set-mode --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --mode multiple

az containerapp revision list --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o table --all

$REVISION_NAME="hello-multirevision--tf0wgs9"
$REVISION_SUFFIX="0000001"
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --image $GREEN_IMAGE `
    --from-revision $REVISION_NAME `
    --revision-suffix $REVISION_SUFFIX

$REVISION_SUFFIX="0000002"
az containerapp revision copy --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --image $BLUE_IMAGE `
    --from-revision $REVISION_NAME `
    --revision-suffix $REVISION_SUFFIX

$REV1="hello-multirevision--0000001"
$REV2="hello-multirevision--0000002"
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --revision-weight hello-multirevision--0000001=50 hello-multirevision--0000002=50


# LABEL BASED TRAFFIC SPLITTING

az containerapp revision label add --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label green --revision hello-multirevision--0000001

az containerapp revision label add --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label blue --revision hello-multirevision--0000002

# change the weight of the traffic to the new revision
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label-weight green=30 blue=70


# promote the staging revision to production
az containerapp ingress traffic set --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --label-weight green=100 blue=0
    
# swap the labels of the revisions
az containerapp revision label swap -n $APPLICATION_NAME -g $RESOURCE_GROUP `
    --source green --target blue

