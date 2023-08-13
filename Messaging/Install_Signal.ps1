$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Get the version info from GitHub since it doesn't seem to appear on the main website for some reason when using Invoke-WebRequest:
$version = $(Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/signalapp/Signal-Desktop/tags" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "/signalapp/Signal-Desktop/releases/tag/v*.*.*") -and ($_.href -notlike "*beta*")} | Select-Object -ExpandProperty href | Select-Object -First 1) -split "/v" | Select-Object -Last 1
$dlLink = "https://updates.signal.org/desktop/signal-desktop-win-$version.exe"
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath