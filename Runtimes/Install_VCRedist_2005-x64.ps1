$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://www.microsoft.com/en-us/download/details.aspx?id=26347"
$response = Invoke-WebRequest -Uri $url
$regex = 'downloadFile":(\[.*?\])'
$jsonMatch = [regex]::Match($response.Content, $regex).Groups[1].Value
if ($jsonMatch -ne $null) {
    $jsonData = $jsonMatch | ConvertFrom-Json
    $urls = $jsonData | ForEach-Object { $_.url }
	$dlLink = $urls | Select-Object | Where-Object { $_ -like "*x64.exe" }
	$file = $dlLink -split "/" | Select-Object -Last 1
}
if ($dlLink -and $file) {
	$InstallerPath = Join-Path $env:TEMP $file
	(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
	Start-Process $InstallerPath -Wait -ArgumentList "/Q" -Verb RunAs
	Remove-Item $InstallerPath
}