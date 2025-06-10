# Read the .env file and set PowerShell variables
Get-Content ../.env | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        $name = $matches[1].Trim('"')
        $value = $matches[2].Trim('"')
        Set-Variable -Name $name -Value $value -Scope Global
#        Write-Host "Set variable: $name = $value"
    }
}

# Verify the variables are loaded
Write-Host "`nLoaded variables:"
Write-Host "RESOURCE_GROUP: $RESOURCE_GROUP"
Write-Host "LOCATION: $LOCATION"
Write-Host "CONTAINERAPPS_ENVIRONMENT: $CONTAINERAPPS_ENVIRONMENT"