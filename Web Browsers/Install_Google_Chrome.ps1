$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "googlechromestandaloneenterprise64.msi"
$dlLink = "https://dl.google.com/tag/s/dl/chrome/install/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item $InstallerPath