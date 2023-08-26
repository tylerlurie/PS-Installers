$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "OriginSetup.exe"
$dlLink = "https://download.dm.origin.com/origin/live/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -ArgumentList "/silent" -Verb RunAs
# Wait until the OriginThinSetupInternal process exists:
While ($null -eq $(Get-Process -Name "OriginThinSetupInternal" -ErrorAction SilentlyContinue))
{
	Start-Sleep -Seconds 1.0
}
Wait-Process -Name "OriginSetup", "OriginThinSetupInternal" # Wait until both processes complete
Stop-Process -Name "Origin" -ErrorAction SilentlyContinue # Prevent process from starting afterward
Remove-Item $InstallerPath