$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "EpicGamesLauncherInstaller.msi"
$dlLink = "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item $InstallerPath