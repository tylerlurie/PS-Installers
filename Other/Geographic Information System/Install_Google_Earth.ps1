$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://support.google.com/earth/answer/168344?hl=en#zippy=%2Cdownload-a-google-earth-pro-direct-installer" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*-x64.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href
$file = $dlLink -split "/"  | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "OMAHA=1" -Verb RunAs
Remove-Item $InstallerPath