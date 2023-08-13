$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$version = (Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*qbittorrent-*.*.*/")} | Select-Object -First 1 | Select-Object -ExpandProperty href) -split "-" | Select-Object -Last 1
$baseLink = Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-$version" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*x64_setup.exe*")} | Select-Object -First 1 | Select-Object -ExpandProperty href
$request = [System.Net.WebRequest]::Create($baseLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$redirectLink = $response.GetResponseHeader("Location")
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath