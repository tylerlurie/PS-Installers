$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://www.emclient.com/dist/latest/setup.msi"
$contentHeaders = Invoke-WebRequest -UseBasicParsing -Uri $dlLink | Select-Object -ExpandProperty Headers
$file = ([System.Net.Mime.ContentDisposition]::new($contentHeaders["Content-Disposition"])).FileName
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$InstallerPath`" /qn /norestart" -Verb RunAs
# It will try to open the PC Settings to change the default app once installed. Stop this from happening:
$settingsProcess = Get-Process -Name "SystemSettings"
If ($settingsProcess) {
    $settingsProcess | ForEach-Object { $_.Kill() }
}
Remove-Item $InstallerPath