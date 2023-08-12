$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://peazip.github.io/peazip-64bit.html" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*peazip-*.WIN64.exe"} | Select-Object -ExpandProperty href
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/VERYSILENT /NORESTART" -Verb RunAs
Remove-Item $InstallerPath