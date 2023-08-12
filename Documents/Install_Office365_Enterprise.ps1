$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlLink = Invoke-WebRequest -uri "https://www.microsoft.com/download/confirmation.aspx?id=49117" -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object {$_.href -like "*officedeploymenttool*"} | Select-Object -ExpandProperty href | Select-Object -First 1
$file = $dlLink -Split "/" | Select-Object -Last 1
$InstallerPath = Join-Path $env:TEMP $file
(New-Object System.Net.WebClient).DownloadFile($dlLink, $InstallerPath)
Start-Process $InstallerPath -Wait -ArgumentList "/extract:$env:TEMP /quiet" -Verb RunAs
Remove-Item $InstallerPath
# Remove the extra configuration files that are bundled with the ODT:
Remove-Item "$env:TEMP\configuration-Office*.xml"
$configFileContents =
'<Configuration>
  <Add OfficeClientEdition="64" Channel="Current" MigrateArch="TRUE">
    <Product ID="O365ProPlusRetail">
      <Language ID="MatchOS" />
      <Language ID="MatchPreviousMSI" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="Lync" />
    </Product>
  </Add>
  <Updates Enabled="TRUE" />
  <RemoveMSI />
  <AppSettings>
    <User Key="software\microsoft\office\16.0\excel\options" Name="defaultformat" Value="51" Type="REG_DWORD" App="excel16" Id="L_SaveExcelfilesas" />
    <User Key="software\microsoft\office\16.0\powerpoint\options" Name="defaultformat" Value="27" Type="REG_DWORD" App="ppt16" Id="L_SavePowerPointfilesas" />
    <User Key="software\microsoft\office\16.0\word\options" Name="defaultformat" Value="" Type="REG_SZ" App="word16" Id="L_SaveWordfilesas" />
  </AppSettings>
  <Display Level="None" AcceptEULA="TRUE" />
</Configuration>'
$configFileName = "Configuration-Office365-Enterprise.xml"
$configFilePath = Join-Path $env:TEMP $configFileName
Out-File -FilePath $configFilePath -InputObject $configFileContents -Encoding utf8
# Installs O365 Enterprise with bare minimum configuration
$file = "setup.exe"
$InstallerPath = Join-Path $env:TEMP $file
Start-Process $InstallerPath -Wait -ArgumentList "/configure $configFilePath" -Verb RunAs
Remove-Item $configFilePath
Remove-Item $InstallerPath