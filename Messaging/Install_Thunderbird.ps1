$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.Web # Required to parse spaces out of URLs for file names
$redirectLink = Invoke-WebRequest -UseBasicParsing -Uri "https://www.thunderbird.net/en-US/download/" | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "https://download.mozilla.org/?product=thunderbird-*-msi-SSL&os=win64&lang=en-US"} | Select-Object -ExpandProperty href | Select-Object -First 1
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = [System.Web.HttpUtility]::UrlDecode([System.IO.Path]::GetFileName($dlLink))
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$InstallerPath`" /qn" -Verb RunAs
Remove-Item $InstallerPath