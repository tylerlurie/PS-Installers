$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -UseBasicParsing -Uri "https://getgreenshot.org/downloads/" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*Greenshot-INSTALLER-*-RELEASE.exe"} | Select-Object -ExpandProperty href
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" -Verb RunAs
# Sometimes the Greenshot installer process continues to run after it's done installing and will not allow the installer to be deleted.
# Try deleting it until successful:
While (Test-Path $InstallerPath) {
	Remove-Item $InstallerPath -ErrorAction SilentlyContinue
}