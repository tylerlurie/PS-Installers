$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://rarlab.com" + (Invoke-WebRequest -UseBasicParsing -Uri "https://rarlab.com/download.htm" | Select-Object -ExpandProperty Links | Where-Object ({$_.href -match "/rar/winrar-x64-\d*.exe"}) | Select-Object -ExpandProperty href | Select-Object -Last 1)
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath