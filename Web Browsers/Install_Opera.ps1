$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$version = (Invoke-WebRequest -UseBasicParsing -Uri "https://get.geo.opera.com/pub/opera/desktop" | Select-Object -ExpandProperty Links | Select-Object -ExpandProperty href | Select-Object -Last 1) -replace "/", ""
$file = "Opera_$($version)_Setup_x64.exe"
$dlLink = "https://get.geo.opera.com/pub/opera/desktop/$version/win/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/silent /allusers=1 /launchopera=0 /enable-installer-stats=0 /enable-stats=0" -Verb RunAs
Remove-Item $InstallerPath