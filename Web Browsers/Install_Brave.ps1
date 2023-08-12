$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "brave_installer-x64.exe"
$dlLink = "https://brave-browser-downloads.s3.brave.com/latest/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "--install --silent --system-level" -Verb RunAs
Remove-Item $InstallerPath