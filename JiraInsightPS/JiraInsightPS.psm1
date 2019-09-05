$ErrorActionPreference = "Stop"

Set-StrictMode -Version Latest

$Class = @(Get-ChildItem -File -Recurse -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'class') -ErrorAction SilentlyContinue)
$Public = @(Get-ChildItem -File -Recurse -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'public') -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -File -Recurse -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'private') -ErrorAction SilentlyContinue)

foreach ($function in @($Class + $Public + $Private)) {

    try {

        . $function.Fullname

    }

    catch {

        Write-Error -ErrorAction Stop -Message "Failed to import function '$($function.fullname)': $_"
    }
}

try {

    $script:M_Config = Import-PowerShellDataFile -Path $PSScriptRoot\Config.psd1 -ErrorAction Stop
}
catch {

    Write-Error -Message "Failed to load module configuration" -ErrorAction Stop

}

