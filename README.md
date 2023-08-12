# PS-Installers
This repository contains a collection of PowerShell scripts to download and automatically install the latest 64-bit version of a given application. These scripts also delete the installers they download, and occasionally other files they use, after installations are finished.

These scripts can in theory be imported into Microsoft Intune as Win32 apps to always install the latest versions and would reduce the amount of maintenance needed to keep Autopilot installations, etc. up to date.

## Installations
For the most part, these scripts will download the MSI installers for applications whenever available. EXEs are downloaded for applications that do not support MSIs.

Applications are typically installed for all users whenever possible, and on a per-user basis when system-wide installation is not supported.

Installations are done silently with no setting configurations done in advance. This means most apps include a desktop shortcut by default.

## Usage
To install a given application from this repository, you can either download an individual script and run it, or run the following line in PowerShell:
```
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/path/to/installer.ps1"))
```

It is preferable to use an Administrator instance PowerShell to avoid having to accept User Account Control promptings while installing applications, but it is not mandatory, as each installation command will prompt to elevate to administrative privileges if it needs them and does not already have them.

To install multiple apps with a single script, you can use an array of links. For example:
```
$links = @(
            "https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Firefox.ps1",
            "https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_HomePrem.ps1",
            "https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Adobe_Acrobat.ps1",
            "https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Compression/Install_7-Zip.ps1",
            "https://github.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Notepad-Plus-Plus.ps1",
            "https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_VLC.ps1",
            "https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Zoom.ps1"
)

foreach ($link in $links)
{
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($link))
}
```
Or if batch scripting is more your thing, you can chain together calls to PowerShell scripts like so:
```
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Firefox.ps1'))"
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_HomePrem.ps1'))"
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Adobe_Acrobat.ps1'))"
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Compression/Install_7-Zip.ps1'))"
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Notepad-Plus-Plus.ps1'))"
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_VLC.ps1'))"
Powershell.exe -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Zoom.ps1'))"
```

## Currently Included Apps
* [7-Zip](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Compression/Install_7-Zip.ps1)
* [Adobe Acrobat](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Adobe_Acrobat.ps1)
* [Brave](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Brave.ps1)
* [Firefox](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Firefox.ps1)
* [Google Chrome](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Google_Chrome.ps1)
* [Microsoft Edge](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Microsoft_Edge.ps1)
* [Notepad++](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Notepad-Plus-Plus.ps1)
* [Office 365 Apps for Business](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_Business.ps1)
* [Office 365 Apps for Enterprise](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_Enterprise.ps1)
* [Office 365 Personal](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_HomePrem.ps1)
* [Opera](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Opera.ps1)
* [Vivaldi](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Vivaldi.ps1)
* [VLC Media Player](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_VLC_Media_Player.ps1)
* [Zoom](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Zoom.ps1)