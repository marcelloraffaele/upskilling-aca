# get the parameter HOWMANY
# if HOWMANY is not set, default to 5
# if HOWMANY is set to forever run forever
# if is set to a number run that number
# for each cycle wait 1 second
# example .\2.test.ps1 -HOWMANY forever
#         .\2.test.ps1 -HOWMANY 100

param(
    [string]$HOWMANY = "5"
)

$RESOURCE_GROUP="apim-demo-rg"
$CONTAINERAPPS_ENVIRONMENT="demo-public-env"
$APPLICATION_NAME="hello"
$fqdn = az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --query "properties.configuration.ingress.fqdn" --output tsv

$url = "https://$fqdn/api/version"

if ($HOWMANY -eq "forever") {
    Write-Host "Running forever... Press Ctrl+C to stop"
    while ($true) {
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get
            Write-Host "Response: $response"
            Start-Sleep -Seconds 1
        }
        catch {
            Write-Host "Error: $_"
            Start-Sleep -Seconds 1
        }
    }
}
else {
    $N = [int]$HOWMANY
    Write-Host "Running $N times..."
    1..$N | ForEach-Object { 
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get
            Write-Host "Request $_`: $response"
            if ($_ -lt $N) { Start-Sleep -Seconds 1 }
        }
        catch {
            Write-Host "Request $_` Error: $_"
            if ($_ -lt $N) { Start-Sleep -Seconds 1 }
        }
    }
}