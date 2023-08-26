$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "wds_current_setup.exe"
$dlLink = "https://windirstat.net/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath