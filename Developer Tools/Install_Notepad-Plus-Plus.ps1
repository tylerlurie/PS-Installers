$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://notepad-plus-plus.org" + (Invoke-WebRequest -Uri "https://notepad-plus-plus.org" -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object { $_.outerHTML -like '*Current Version*' }).href
$dlLink = (Invoke-WebRequest -Uri $baseLink -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*npp.*.Installer.x64.exe"}).href | Select-Object -First 1
$file = $dlLink -Split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath