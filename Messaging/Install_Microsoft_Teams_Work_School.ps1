$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$redirectLink = "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true"
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = "Teams_windows_x64.msi"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$InstallerPath`" /qn" -Verb RunAs
Start-Process "`"${env:ProgramFiles(x86)}\Teams Installer\Teams.exe`"" # Install Teams for the current logged-in user without having to reboot
While ((Get-Process "Update" -ErrorAction SilentlyContinue) -eq $null) {
	Start-Sleep 1.0
}
Wait-Process "Update"
Stop-Process -ProcessName "Teams"
Remove-Item $InstallerPath