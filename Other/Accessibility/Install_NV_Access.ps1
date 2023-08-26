$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = (Invoke-WebRequest -UseBasicParsing -Uri 'https://www.nvaccess.org/files/nvda/releases/stable/' | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*.exe")}).href
$dlLink = "https://www.nvaccess.org/files/nvda/releases/stable/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "--minimal --install-silent --enable-start-on-logon=True" -Verb RunAs
# It will try to open the PC Settings to change the default app once installed. Stop this from happening:
$settingsProcess = Get-Process -Name "SystemSettings"
If ($settingsProcess) {
    $settingsProcess | ForEach-Object { $_.Kill() }
}
Remove-Item $InstallerPath