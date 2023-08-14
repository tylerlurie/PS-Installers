$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "TeamViewer_Setup.exe"
$dlLink = "https://download.teamviewer.com/download/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath