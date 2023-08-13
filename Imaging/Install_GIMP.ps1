$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https:" + (Invoke-WebRequest -UseBasicParsing -Uri "https://www.gimp.org/downloads/" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*.exe") -and ($_.href -notlike "*gimp-help*")} | Select-Object -ExpandProperty href)
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/VERYSILENT /NORESTART /ALLUSERS" -Verb RunAs
Remove-Item $InstallerPath