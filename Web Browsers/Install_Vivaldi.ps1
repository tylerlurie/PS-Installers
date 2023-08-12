$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://vivaldi.com/download" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*x64.exe"} | Select-Object -ExpandProperty href | Select-Object -First 1
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "--vivaldi-silent --do-not-launch-chrome --system-level" -Verb RunAs
Remove-Item $InstallerPath