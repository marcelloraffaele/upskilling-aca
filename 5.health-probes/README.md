This was created from the https://learn.microsoft.com/en-gb/azure/container-apps/azure-resource-manager-api-spec?tabs=yaml#container-app-examples

# demo instructions

Extract the current configuration to a file, 

```powershell
az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP --output yaml > usecase2-export.yaml
```
modify it

```yaml
    probes:
      - type: Liveness
        httpGet:
          path: "/liveness"
          port: 8080
        initialDelaySeconds: 3
        periodSeconds: 3
      - type: Readiness
        httpGet:
          path: "/readiness"
          port: 8080
        initialDelaySeconds: 3
        periodSeconds: 3
      - type: Startup
        httpGet:
          path: "/started"
          port: 8080
        initialDelaySeconds: 1
        periodSeconds: 5
        failureThreshold: 3
      env:
      - name: "COLOR_MODE"
        value: "GREEN"
```

and

```yaml
      minReplicas: 1
      maxReplicas: 5
      rules:
      - name: httpscalingrule
        custom:
          type: http
          metadata:
            concurrentRequests: '50'
```

and then update the Container App with the new configuration.

```powershell
az containerapp update --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --yaml usecase2.yaml 
```



## kusto query
```kusto
ContainerAppConsoleLogs
| where ContainerAppName == "usecase2"

ContainerAppSystemLogs
| where ContainerAppName == "usecase2"
```