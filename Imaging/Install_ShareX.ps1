$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://github.com" + (Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/ShareX/ShareX" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*releases/tag*"} | Select-Object -ExpandProperty href)
$version = ($baseLink -split "/" | Select-Object -Last 1) -replace "v", ""
$dlLink = "https://github.com/ShareX/ShareX/releases/download/v$version/ShareX-$version-setup.exe"
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/VERYSILENT /NORESTART /NORUN" -Verb RunAs
Remove-Item $InstallerPath