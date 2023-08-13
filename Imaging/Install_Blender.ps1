$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$version = Invoke-WebRequest -UseBasicParsing -Uri "https://mirror.clarkson.edu/blender/release/" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*Blender*.*/") -and ($_.href -notlike "*beta*") -and ($_.href -notlike "*Benchmark*")} | Select-Object -Last 1 | Select-Object -ExpandProperty href
$dlLink = "https://mirror.clarkson.edu/blender/release/$($version)" + (Invoke-WebRequest -UseBasicParsing -Uri "https://mirror.clarkson.edu/blender/release/$($version)" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*-x64.msi")} | Select-Object -Last 1 | Select-Object -ExpandProperty href)
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath ALLUSERS=1 /qn" -Verb RunAs
Remove-Item $InstallerPath