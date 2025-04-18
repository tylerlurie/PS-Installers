$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "SpotifyFullSetup.exe"
$dlLink = "https://download.scdn.co/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -ArgumentList "/silent"
# Wait for the Spotify process to start, and then stop it:
While ((Get-Process "Spotify" -ErrorAction SilentlyContinue) -eq $null) {
	Start-Sleep 1.0
}
Stop-Process -ProcessName "Spotify"
Remove-Item $InstallerPath
