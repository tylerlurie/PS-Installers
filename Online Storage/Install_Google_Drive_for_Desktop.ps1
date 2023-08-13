$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "GoogleDriveSetup.exe"
$dlLink = "https://dl.google.com/drive-file-stream/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "--silent" -Verb RunAs
Start-Process taskkill.exe -Wait -ArgumentList "/F /IM GoogleDriveFS.exe"
Remove-Item $InstallerPath