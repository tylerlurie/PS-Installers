$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$redirectLink = "https://www.apple.com/itunes/download/win64"
$request = [System.Net.WebRequest]::Create($redirectLink)
$request.AllowAutoRedirect=$false
$response=$request.GetResponse()
$dlLink = $response.GetResponseHeader("Location")
$file = "iTunes64Setup.exe"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
# First extract the files we need:
Start-Process $InstallerPath -Wait -ArgumentList "/extract $env:TEMP" -Verb RunAs
# Run the remaining setup files for iTunes:
Start-Process msiexec.exe -Wait -ArgumentList "/i $env:TEMP\AppleMobileDeviceSupport64.msi /qn"
Start-Process msiexec.exe -Wait -ArgumentList "/i $env:TEMP\iTunes64.msi REBOOT=ReallySuppress /qn"
Remove-Item -Path "$env:TEMP\AppleMobileDeviceSupport64.msi"
Remove-Item -Path "$env:TEMP\AppleSoftwareUpdate.msi"
Remove-Item -Path "$env:TEMP\Bonjour64.msi"
Remove-Item -Path "$env:TEMP\iTunes64.msi"
Remove-Item -Path "$env:TEMP\$file"
Remove-Item -Path "$env:TEMP\SetupAdmin.exe"