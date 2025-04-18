$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$redirectLink = "https://go.microsoft.com/fwlink/?linkid=2243204"
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = "teamsbootstrapper.exe"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "-p" -Verb RunAs
Remove-Item $InstallerPath