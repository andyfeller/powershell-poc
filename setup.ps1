# Adding current path (workspace root) to PowerShell modules path; needed for testing and publishing
Write-Output (@'
Appending workspace to PS module path
   Workspace: {0}
   env:PSModulePath: {1}
'@ -f $pwd.Path, $env:PSModulePath)

$env:PSModulePath += "$([System.IO.Path]::PathSeparator)$($pwd.Path)"


# Register Powershell repository; needed for publishing
$repositoryName = "poweshell-poc"
$repositoryUri = "https://pkgs.dev.azure.com/andyfeller/powershell-poc/_packaging/powershell-poc/nuget/v2"

Write-Output (@'
Registering PS repository
    Name: {0}
    URI: {1}
'@ -f $repositoryName, $repositoryUri)

Register-PSRepository -Name $repositoryName -SourceLocation $repositoryUri -PublishLocation $repositoryUri