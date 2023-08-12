$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$file = "python-2.7.10.amd64.msi"
$dlLink = "https://www.python.org/ftp/python/2.7.10/$file"
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process msiexec.exe -Wait -ArgumentList "/i $InstallerPath ALLUSERS=1 ADDLOCAL=DefaultFeature,Extensions,TclTk,Documentation,pip_feature,PrependPath /qn" -Verb RunAs
Remove-Item $InstallerPath