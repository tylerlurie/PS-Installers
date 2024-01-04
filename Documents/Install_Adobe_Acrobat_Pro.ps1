$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "Acrobat_DC_Web_x64_WWMUI.zip"
$dlLink = "https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/win32/$file"
$zipPath = Join-Path $env:TEMP $file
$outputFolder = $file -replace ".{4}$" # Removes .zip extension for output folder
$outputPath = Join-Path $env:TEMP $outputFolder
(New-Object System.Net.WebClient).DownloadFile($dlLink, $zipPath)
Expand-Archive -Path $zipPath -DestinationPath $outputPath
$setupPath = $outputPath + "\Adobe Acrobat\setup.exe"
Start-Process $setupPath -Wait -ArgumentList "/sAll /rs /msi EULA_ACCEPT=YES" -Verb RunAs
Remove-Item -Recurse -Force $outputPath
Remove-Item $zipPath