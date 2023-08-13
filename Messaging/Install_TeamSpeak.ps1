$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://files.teamspeak-services.com/releases/client/" + (Invoke-WebRequest -UseBasicParsing -Uri "https://files.teamspeak-services.com/releases/client/" | Select-Object -ExpandProperty Links | Select-Object -ExpandProperty href)[-2] + "/"
$dlLink = $baseLink + (Invoke-WebRequest -UseBasicParsing -Uri $baseLink | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "TeamSpeak*-Client-win64-*.exe"} | Select-Object -ExpandProperty href)
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath