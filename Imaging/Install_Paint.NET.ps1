$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://github.com" + (Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/paintdotnet/release/" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*releases/tag*"} | Select-Object -ExpandProperty href)
$version = ($baseLink -split "/" | Select-Object -Last 1) -replace "v", ""
$dlLink = "https://github.com/paintdotnet/release/releases/download/v$version/paint.net.$version.winmsi.x64.zip"
$zipFile = $dlLink -split "/" | Select-Object -Last 1
$file = $zipFile -replace ".zip", ".msi"
$zipPath = Join-Path $env:TEMP $zipFile
$outDir = $zipFile -replace ".{4}$" # Remove .zip extension
(New-Object System.Net.WebClient).DownloadFile($dlLink, $zipPath)
Expand-Archive -Path $zipPath -DestinationPath (Join-Path $env:TEMP $outDir)
$InstallerPath = [IO.Path]::Combine($env:TEMP, $outDir, $file)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item (Join-Path $env:TEMP $outDir) -Recurse -Force
Remove-Item $zipPath