Write-Verbose "CloudRemoting module"

if (Get-Module AWS.Tools.Common -ListAvailable) {
    Import-Module AWS.Tools.Common
} elseif (Get-Module AWSPowerShell.NetCore -ListAvailable) {
    Import-Module AWSPowerShell.NetCore
} elseif (Get-Module AWSPowershell -ListAvailable) {
    Import-Module AWSPowershell
} else {
    Write-Warning "AWS.Tools, AWSPowershell or AWSPowerShell.NetCore is not found, but some of the cmdlets requires it."
    Write-Warning "Please make sure you have installed it for proper functioning."
    Write-Warning "You can install it by 'PowerShellGet\Install-Module AWSPowershell -Scope CurrentUser' or by 'https://s3.amazonaws.com/aws-cli/AWSCLI64.msi'"
}

$functionFilter = Join-Path $PSScriptRoot "Functions\*.ps1"
Get-ChildItem -Path $functionFilter -Recurse | Foreach-Object {
    Write-Verbose "Loading file $($_.Name).."
    . $_.FullName
}
