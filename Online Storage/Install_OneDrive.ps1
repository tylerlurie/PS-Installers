$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$baseLink = "https://go.microsoft.com/fwlink/?LinkID=2182910"
$request = [System.Net.WebRequest]::Create($baseLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$redirectLink = $response.GetResponseHeader("Location")
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -ArgumentList "/silent /allusers" -Verb RunAs
While (Test-Path $InstallerPath) {
	Remove-Item $InstallerPath -ErrorAction SilentlyContinue
}