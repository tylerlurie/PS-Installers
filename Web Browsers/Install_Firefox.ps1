$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.Web # Required to parse spaces out of URLs for file names
$redirectLink = "https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64"
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = [System.Web.HttpUtility]::UrlDecode([System.IO.Path]::GetFileName($dlLink))
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$InstallerPath`" /qn" -Verb RunAs
Remove-Item $InstallerPath