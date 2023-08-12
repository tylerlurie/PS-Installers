$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.Web # Required to parse spaces out of URLs for file names
$redirectLink = "https://www.foxit.com/downloads/latest.html?product=Foxit-Reader&platform=Windows&version=&package_type=&language=English&distID="
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = [System.Web.HttpUtility]::UrlDecode([System.IO.Path]::GetFileName($dlLink))
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "/VERYSILENT /NORESTART" -Verb RunAs
Remove-Item $InstallerPath