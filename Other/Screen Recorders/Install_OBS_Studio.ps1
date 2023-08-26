$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = (Invoke-WebRequest -Uri "https://obsproject.com" -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*OBS-Studio-*-Full-Installer-x64.exe"}).href
$file = $dlLink -Split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath