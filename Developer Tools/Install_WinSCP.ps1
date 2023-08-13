$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://winscp.net" + (Invoke-WebRequest -UseBasicParsing -Uri "https://winscp.net/eng/download.php" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*WinSCP-*-Setup.exe"} | Select-Object -ExpandProperty href)
$file = $baseLink -split "/" | Select-Object -Last 1
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri $baseLink | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*$file*secure*"} | Select-Object -ExpandProperty href | Select-Object -First 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/VERYSILENT /NORESTART /ALLUSERS" -Verb RunAs
Remove-Item $InstallerPath