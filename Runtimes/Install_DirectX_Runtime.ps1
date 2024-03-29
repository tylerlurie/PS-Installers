$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://www.microsoft.com/en-us/download/details.aspx?id=8109" | Select-Object -ExpandProperty Links | Where-Object { $_.href -like "*.exe" } | Select-Object -ExpandProperty href
$file = $dlLink -split "/" | Select-Object -Last 1
$PackagePath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $PackagePath)
$outputDir = Join-Path $env:TEMP "DirectX"
Start-Process $PackagePath -Wait -ArgumentList "/Q /C /T:`"$outputDir`"" -Verb RunAs
$InstallerPath = Join-Path $outputDir "DXSETUP.exe"
Start-Process $InstallerPath -Wait -ArgumentList "/silent" -Verb RunAs
Remove-Item $PackagePath
Remove-Item $outputDir -Recurse -Force
Remove-Item $InstallerPath