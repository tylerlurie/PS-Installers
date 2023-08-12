$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "ZoomInstallerFull.msi"
$dlLink = "https://zoom.com/client/latest/$($file)?archType=x64"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item $InstallerPath