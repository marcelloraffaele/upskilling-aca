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

$APPLICATION_NAME="hello"
$fqdn = az containerapp show --name $APPLICATION_NAME --resource-group $RESOURCE_GROUP `
    --query "properties.configuration.ingress.fqdn" --output tsv

$url = "https://$fqdn/api/version"
Write-Host "Testing URL: $url"

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