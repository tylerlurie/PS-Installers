$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$response = Invoke-WebRequest -Uri "https://dotnet.microsoft.com/en-us/download/dotnet/8.0" -UseBasicParsing
$baseLink = "https://dotnet.microsoft.com" + ($response.Links | Where-Object {($_.href -like "*runtime-desktop-8.[0-9]*-windows-x64-installer") -and ($_.href -notlike "*preview*")} | Select-Object -ExpandProperty href)[0]
$dlLinkResponse = Invoke-WebRequest -Uri $baseLink -UseBasicParsing
$dlLink = ($dlLinkResponse.Links | Where-Object {($_.href -like "*.exe")}).href[0]
$file = ($dlLink -split "/")[-1]
$InstallerPath = Join-Path $env:TEMP $file
if (-not (Test-Path -Path $env:TEMP)) { New-Item -ItemType Directory -Path $env:TEMP }
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "/install /quiet /norestart" -Verb RunAs
Remove-Item $InstallerPath
