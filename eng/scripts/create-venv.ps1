<#! 
.SYNOPSIS
Creates a virtual environment for a CI machine.

.DESCRIPTION
If the virtual environment directory already exists, it will skip the creation. The location of the virtual environment will be stored in a variable
named <VenvName>_LOCATION. The location will be RepoRoot + VenvName.

.PARAMETER VenvName
The name of the virtual environment which will be created.

.PARAMETER RepoRoot
The root of the repository.
#>
param(
    [Parameter(Mandatory = $true)]
    [string] $VenvName,
    # The root of the repository should be $(Build.SourcesDirectory) passed in from template
    [Parameter(Mandatory = $true)]
    [string] $RepoRoot
)

$venvPath = Join-Path $RepoRoot $VenvName
if (!(Test-Path $venvPath)) {
    Write-Host "Creating virtual environment '$VenvName'."
    python -m venv "$venvPath"
    Write-Host "Virtual environment '$VenvName' created."
    Write-Host "##vso[task.setvariable variable=$($VenvName)_LOCATION]$venvPath"
}
else {
    Write-Host "Virtual environment '$VenvName' already exists. Skipping creation."
}
