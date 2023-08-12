$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Architecture = "x64"
$Platform = "Windows"
$redirectLink = "https://edgeupdates.microsoft.com/api/products?view=enterprise"
$jsonObj = Invoke-RestMethod -Uri $redirectLink -UseBasicParsing
$selectedIndex = [array]::indexof($jsonObj.Product, "Stable")
$selectedVersion = (([Version[]](($jsonObj[$selectedIndex].Releases | Where-Object { $_.Architecture -eq $Architecture -and $_.Platform -eq $Platform}).ProductVersion) | Sort-Object -Descending)[0]).ToString(4)
$selectedObject = $jsonObj[$selectedIndex].Releases | Where-Object { $_.Architecture -eq $Architecture -and $_.Platform -eq $Platform -and $_.ProductVersion -eq $selectedVersion }
$dlLink = $selectedObject.Artifacts.Location
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$InstallerPath`" /qn" -Verb RunAs
Remove-Item $InstallerPath