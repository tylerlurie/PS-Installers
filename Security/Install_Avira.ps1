$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = "https://download.avira.com/package/antivirus/win/en-us/avira_antivirus_en-us.exe"
$file = $dlLink -split "/"  | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
$setupFileContents = 
'[DATA]
DestinationPath=%PROGRAMFILES%
ProgramGroup=1
DesktopIcon=1
KeyFile="C:\Program Files (x86)\Avira\Antivirus\hbedv.key"
AVWinIni="C:\ProgramData\Avira\Antivirus\CONFIG\avwin.ini"
RestartWindows=0
ShowRestartMessage=0
MailScanner=1
Guard=1
WebGuard=1
ShellExtension=1
SetupMode=Modify
RootKit=1
MgtFirewall=0
Password='
$setupFileName = "setup.inf"
$setupFilePath = Join-Path $env:TEMP $setupFileName
Out-File -FilePath $setupFilePath -InputObject $setupFileContents -Encoding utf8
Start-Process "$InstallerPath" -Wait -ArgumentList "/INF=$setupFilePath" -Verb RunAs
Remove-Item $setupFilePath
Remove-Item $InstallerPath