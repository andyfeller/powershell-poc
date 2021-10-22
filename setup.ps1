# Adding current path (workspace root) to PowerShell modules path; needed for testing and publishing
$env:PSModulePath += "$([System.IO.Path]::PathSeparator)$($pwd.Path)"

# Register Powershell repository; needed for publishing
Register-PSRepository -Name "powershell-poc" -SourceLocation "https://pkgs.dev.azure.com/andyfeller/powershell-poc/_packaging/powershell-poc/nuget/v2" -PublishLocation "https://pkgs.dev.azure.com/andyfeller/powershell-poc/_packaging/powershell-poc/nuget/v2" -Force