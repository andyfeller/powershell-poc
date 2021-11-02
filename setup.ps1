# Set variables based on optional env vars or defaults
$modulePath = $env:REPO_MODULE_PATH ?? $pwd.Path
$repositoryName = $env:REPOSITORY_NAME ?? "powershell-poc"
$repositoryUri = $env:REPOSITORY_URI ?? "https://pkgs.dev.azure.com/andyfeller/powershell-poc/_packaging/powershell-poc/nuget/v2"


# Adding current path (workspace root) to PowerShell modules path; needed for testing and publishing
Write-Output (@'
Appending workspace to PS module path
   Workspace: {0}
   env:PSModulePath: {1}
'@ -f $modulePath, $env:PSModulePath)

$env:PSModulePath += "$([System.IO.Path]::PathSeparator)$modulePath"