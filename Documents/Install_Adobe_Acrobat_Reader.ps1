$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$TwoLetterISOLanguageName = (Get-WinSystemLocale).TwoLetterISOLanguageName
$windowsVersion = ((Get-ComputerInfo).OsName).Split(" ")[2]
$displayName = (Invoke-RestMethod -Uri "https://rdc.adobe.io/reader/products?lang=$($TwoLetterISOLanguageName)&site=enterprise&os=Windows%20$($windowsVersion)&api_key=dc-get-adobereader-cdn" -UseBasicParsing).products.reader.displayName
$Version = (Invoke-RestMethod -Uri "https://rdc.adobe.io/reader/products?lang=$($TwoLetterISOLanguageName)&site=enterprise&os=Windows%20$($windowsVersion)&api_key=dc-get-adobereader-cdn" -UseBasicParsing).products.reader.version.Replace(".", "")
$downloadURL = (Invoke-RestMethod -Uri "https://rdc.adobe.io/reader/downloadUrl?name=$($displayName)&os=Windows%20$windowsVersion&site=enterprise&lang=$($TwoLetterISOLanguageName)&api_key=dc-get-adobereader-cdn" -UseBasicParsing).downloadURL
$file = (Invoke-RestMethod -Uri "https://rdc.adobe.io/reader/products?lang=en&site=enterprise&os=Windows $($windowsVersion)&api_key=dc-get-adobereader-cdn" -UseBasicParsing).saveName
if ($downloadURL -match "reader")
{
	$Version = (Invoke-RestMethod -Uri "https://rdc.adobe.io/reader/products?lang=en&site=enterprise&os=Windows $($windowsVersion)&api_key=dc-get-adobereader-cdn" -UseBasicParsing).products.reader.version.Replace(".", "")
	$IetfLanguageTag = (Get-WinSystemLocale).IetfLanguageTag.Replace("-", "_")
	$dlLink = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/$($Version)/AcroRdrDCx64$($Version)_$($IetfLanguageTag).exe"
	$file = Split-Path -Path $dlLink -Leaf
}
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/sAll /rs /msi EULA_ACCEPT=YES" -Verb RunAs
Remove-Item $InstallerPath