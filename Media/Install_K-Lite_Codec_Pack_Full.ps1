$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://codecguide.com/download_k-lite_codec_pack_full.htm" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*K-Lite_Codec_Pack_*_Full.exe"} | Select-Object -ExpandProperty href | Select-Object -First 1
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/VERYSILENT /NORESTART" -Verb RunAs
Remove-Item $InstallerPath