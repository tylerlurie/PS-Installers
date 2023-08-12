$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://7-zip.org/" + (Invoke-WebRequest -UseBasicParsing -Uri 'https://7-zip.org/download.html' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*-x64.msi")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
$file = $dlLink -split "/"  | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item $InstallerPath