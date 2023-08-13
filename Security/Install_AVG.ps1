$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://bits.avcdn.net/productfamily_ANTIVIRUS/insttype_FREE/platform_WIN_AVG/installertype_FULL/build_RELEASE/cookie_mmm_bav_998_999_000_m"
$file = "avg_antivirus_free_offline_setup.exe"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "/silent" -Verb RunAs
Remove-Item $InstallerPath