$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://www.sumatrapdfreader.org" + (Invoke-WebRequest -UseBasicParsing -Uri "https://www.sumatrapdfreader.org/download-free-pdf-viewer" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*SumatraPDF-*64-install.exe"} | Select-Object -ExpandProperty href)
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "-s -d `"C:\Program Files\SumatraPDF`"" -Verb RunAs
Remove-Item $InstallerPath