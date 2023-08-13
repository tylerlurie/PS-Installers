$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.Web # Required to parse spaces out of URLs for file names
$redirectLink = "https://dropbox.com/download?full=1&os=win"
$request = [System.Net.HttpWebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$true
$response=$request.GetResponse()
$dlLink = $response.ResponseURI.AbsoluteUri
$file = [System.Web.HttpUtility]::UrlDecode([System.IO.Path]::GetFileName($dlLink))
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process "$InstallerPath" -Wait -ArgumentList "/NOLAUNCH" -Verb RunAs
Remove-Item $InstallerPath