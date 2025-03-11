$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$versions = (Invoke-WebRequest -UseBasicParsing -Uri "https://get.geo.opera.com/pub/opera/desktop" | Select-Object -ExpandProperty Links | Select-Object -ExpandProperty href)
$latestVersion = $versions | Where-Object { $_ -match '\d+\.\d+\.\d+\.\d+' } | ForEach-Object { if ($_ -match '(\d+\.\d+\.\d+\.\d+)') { $matches[1] } } | Sort-Object { [version]$_ } | Select-Object -Last 1
$file = "Opera_$($latestVersion)_Setup_x64.exe"
$dlLink = "https://get.geo.opera.com/pub/opera/desktop/$latestVersion/win/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/silent /allusers=1 /launchopera=0 /enable-installer-stats=0 /enable-stats=0" -Verb RunAs
Remove-Item $InstallerPath
