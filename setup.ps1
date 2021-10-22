Write-Host ('Initial PowerShell module path: {0}' -f $env:PSModulePath)
$env:PSModulePath += "$([System.IO.Path]::PathSeparator)$($pwd.Path)"
Write-Host ('Including workspace: {0}' -f $env:PSModulePath)