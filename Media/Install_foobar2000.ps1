$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://www.foobar2000.org" + (Invoke-WebRequest -UseBasicParsing -Uri "https://www.foobar2000.org/download" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*foobar2000_*.exe") -and ($_.href -notlike "*preview*")} | Select-Object -ExpandProperty href) -replace "getfile", "files"
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath