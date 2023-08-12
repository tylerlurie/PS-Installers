$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = (Invoke-WebRequest -UseBasicParsing -Uri 'https://get.videolan.org/vlc/last/win64/' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*-win64.msi")}).href
$dlLink = "https://get.videolan.org/vlc/last/win64/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item $InstallerPath