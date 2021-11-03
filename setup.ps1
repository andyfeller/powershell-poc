Function Update-ScriptFileInfoVersion {
  param([string]$path, [int]$newRevision)

  $currentVersion = Test-ScriptFileInfo -Path $path | Select-Object -ExpandProperty Version
  $currentVersion = [System.Version]::Parse($currentVersion)
  $newVersion = ("{0}.{1}.{2}.{3}" -f $currentVersion.Major, $currentVersion.Minor, $currentVersion.Build, $newRevision)

  Update-ScriptFileInfo -Path $path -Version $newVersion
}

Function Update-ModuleManifestVersion {
  param([string]$path, [int]$newRevision)

  $currentVersion = Test-ModuleManifest -Path $path | Select-Object -ExpandProperty Version
  $newVersion = [System.Version]$("{0}.{1}.{2}.{3}" -f $currentVersion.Major, $currentVersion.Minor, $currentVersion.Build, $newRevision)

  Update-ModuleManifest -Path $path -ModuleVersion $newVersion
}

# Set variables based on optional env vars or defaults
$modulePath = "$($env:GITHUB_WORKSPACE ?? $PSScriptRoot)/modules"

# Adding current path (workspace root) to PowerShell modules path; needed for testing and publishing
Write-Output (@'
Appending workspace to PS module path
   Workspace: {0}
   env:PSModulePath: {1}
'@ -f $modulePath, $env:PSModulePath)

$env:PSModulePath += "$([System.IO.Path]::PathSeparator)$modulePath"