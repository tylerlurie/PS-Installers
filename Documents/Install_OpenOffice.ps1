$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.Web # Required to parse spaces out of URLs for file names
$version = Invoke-WebRequest -UseBasicParsing -Uri "https://downloads.apache.org/openoffice/" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*.*.*/")} | Select-Object -ExpandProperty href
$dlLink = "https://downloads.apache.org/openoffice/$($version)binaries/en-US/" + (Invoke-WebRequest -UseBasicParsing -Uri "https://downloads.apache.org/openoffice/$($version)binaries/en-US/" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "Apache_OpenOffice_*.*.*_Win_x86_install_en-US.exe")} | Select-Object -ExpandProperty href)
$file = $dlLink -split "/"  | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "/S /v /qb RebootYesNo=No" -Verb RunAs
Remove-Item $InstallerPath