# revisions
# https://learn.microsoft.com/en-us/cli/azure/containerapp/revision?view=azure-cli-latest

# init vars from .env
.\0.init-variables.ps1
#or
#$RESOURCE_GROUP="<your-resource-group>"
#$CONTAINERAPPS_ENVIRONMENT="<your-containerapp-environment>"
#$APPLICATION_NAME="<your-application-name>"


$DEFAULT_IMAGE="ghcr.io/marcelloraffaele/hello:main"

# Create a container app
az containerapp create --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $DEFAULT_IMAGE `
    --target-port 8080 --ingress external --query properties.configuration.ingress.fqdn


az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP -o yaml > containerapp.yaml


# adjust the containerapp.yaml file to add the sidecar container
#- name: troubleshooting-sidecar
#  image: busybox
#  command: ["/bin/sh", "-c", "while true; do sleep 3600; done"]
#  resources:
#    cpu: 0.1
#    memory: 0.1Gi
az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --yaml containerapp.yaml

#for ubuntu:
# apt update && sudo apt upgrade
# apt install curl