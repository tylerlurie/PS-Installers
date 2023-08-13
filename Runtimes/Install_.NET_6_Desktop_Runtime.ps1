$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://dotnet.microsoft.com" + (Invoke-WebRequest -uri "https://dotnet.microsoft.com/en-us/download/dotnet/6.0" -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*runtime-desktop-6.[0-9]*-windows-x64-installer") -and ($_.href -notlike "*preview*")} | Select-Object -ExpandProperty href)[0]
$dlLink = ((Invoke-WebRequest -uri $baseLink -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*.exe")}).href)[0]
$file = ($dlLink -split "/")[-1]
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/install /quiet /norestart" -Verb RunAs
Remove-Item $InstallerPath