$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://www.voidtools.com" + (Invoke-WebRequest -UseBasicParsing -Uri "https://www.voidtools.com/downloads/" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*Everything-*x64.msi"} | Select-Object -ExpandProperty href)
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath ALLUSERS=1 /qn" -Verb RunAs
Remove-Item $InstallerPath