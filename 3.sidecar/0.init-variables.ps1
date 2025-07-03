Get-Content .env | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        $name = $matches[1].Trim('"')
        $value = $matches[2].Trim('"')
        Set-Variable -Name $name -Value $value -Scope Global
        Write-Host "$name = $value"
    }
}