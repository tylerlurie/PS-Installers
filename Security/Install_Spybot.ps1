$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://www.safer-networking.org/products/spybot-free-edition/download-mirror-1/" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href
$file = $dlLink -split "/"  | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -ArgumentList "/VERYSILENT /NORESTART" -Verb RunAs
While (Test-Path "$InstallerPath") {
	Remove-Item $InstallerPath -ErrorAction SilentlyContinue
}