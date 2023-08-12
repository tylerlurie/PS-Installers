$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Credit to Evergreen on PSGallery for this one - https://www.powershellgallery.com/packages/Evergreen/19.10.21/Content/Public%5CGet-LibreOffice.ps1
$url = "https://www.libreoffice.org/download/download/"
$response = Invoke-WebRequest -UseBasicParsing -Uri $url -ErrorAction SilentlyContinue
# Search for their big green logo version number '<span class="dl_version_number">*</span>'
$content = $response.Content
$spans = $content.Replace('<span', '#$%^<span').Replace('</span>', '</span>#$%^').Split('#$%^') | Where-Object { $_ -like '<span class="dl_version_number">*</span>' }
$verBlock = ($spans).Replace('<span class="dl_version_number">', '').Replace('</span>', '')
If ($Release -eq "Latest") {
	$version = [version]::new($($verblock | Select-Object -First 1))
}
Else {
	$version = [version]::new($($verblock | Select-Object -Last 1))
}
$rootUrl = "https://download.documentfoundation.org/libreoffice/stable/"
$dlLink = "$rootUrl$($version.ToString())/win/x86_64/LibreOffice_$($version.ToString())_Win_x64.msi"
$file = $dlLink -split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath /qn" -Verb RunAs
Remove-Item $InstallerPath