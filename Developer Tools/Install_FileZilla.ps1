$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36" -UseBasicParsing -Uri "https://filezilla-project.org/download.php?show_all=1" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "https://*win64-setup.exe*"} | Select-Object -ExpandProperty href
$file = (($dlLink -split "/" | Select-Object -Last 1) -split "\?" | Select-Object -First 1)
$InstallerPath = Join-Path $env:TEMP $file
$downloader = New-Object System.Net.WebClient
$downloader.Headers['User-Agent'] = '"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36"'
$downloader.DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/S" -Verb RunAs
Remove-Item $InstallerPath