# Set variables based on optional env vars or defaults
$modulePath = "$($env:GITHUB_WORKSPACE ?? $PSScriptRoot)/modules"

# Adding current path (workspace root) to PowerShell modules path; needed for testing and publishing
Write-Output (@'
Appending workspace to PS module path
   Workspace: {0}
   env:PSModulePath: {1}
'@ -f $modulePath, $env:PSModulePath)

$env:PSModulePath += "$([System.IO.Path]::PathSeparator)$modulePath"