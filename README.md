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
* [.NET 3.1 Desktop Runtime](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Runtimes/Install_.NET_3.1_Desktop_Runtime.ps1)
* [.NET 5 Desktop Runtime](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Runtimes/Install_.NET_5_Desktop_Runtime.ps1)
* [.NET 6 Desktop Runtime](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Runtimes/Install_.NET_6_Desktop_Runtime.ps1)
* [.NET 7 Desktop Runtime](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Runtimes/Install_.NET_7_Desktop_Runtime.ps1)
* [.NET Framework 4.8](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Runtimes/Install_.NET_Framework_4.8.ps1)
* [7-Zip](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Compression/Install_7-Zip.ps1)
* [Adobe Acrobat](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Adobe_Acrobat.ps1)
* [Audacity](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_Audacity.ps1)
* [Blender](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Imaging/Install_Blender.ps1)
* [Brave](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Brave.ps1)
* [Discord](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Discord.ps1)
* [Dropbox](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Online%20Storage/Install_Dropbox.ps1)
* [eM Client](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_eM_Client.ps1)
* [FileZilla](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_FileZilla.ps1)
* [Firefox](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Firefox.ps1)
* [foobar2000](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_foobar2000.ps1)
* [Foxit Reader](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Foxit_Reader.ps1)
* [FreeOffice](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_FreeOffice.ps1)
* [GIMP](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Imaging/Install_GIMP.ps1)
* [Google Chrome](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Google_Chrome.ps1)
* [Google Drive for Desktop](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Online%20Storage/Install_Google_Drive_for_Desktop.ps1)
* [Greenshot](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Imaging/Install_Greenshot.ps1)
* [iTunes](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_iTunes.ps1)
* [Java JDK](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Java_JDK.ps1)
* [K-Lite Codec Pack](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_K-Lite_Codec_Pack_Full.ps1)
* [LibreOffice](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_LibreOffice.ps1)
* [Microsoft Edge](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Microsoft_Edge.ps1)
* [Microsoft OneDrive](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Online%20Storage/Install_OneDrive.ps1)
* [Microsoft Teams for Home or Small Business](https://github.com/tylerlurie/PS-Installers/blob/main/Messaging/Install_Microsoft_Teams_Home_Small_Business.ps1)
* [Microsoft Teams for Work or School](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Microsoft_Teams_Work_School.ps1)
* [Notepad++](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Notepad-Plus-Plus.ps1)
* [Office 365 Apps for Business](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_Business.ps1)
* [Office 365 Apps for Enterprise](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_Enterprise.ps1)
* [Office 365 Personal](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Office365_HomePrem.ps1)
* [OpenOffice](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_OpenOffice.ps1)
* [Opera](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Opera.ps1)
* [Paint.NET](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Imaging/Install_Paint.NET.ps1)
* [PeaZip](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Compression/Install_PeaZip.ps1)
* [PuTTY](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_PuTTY.ps1)
* [Python 2.7](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Python_2.7.ps1)
* [Python 3](https://github.com/tylerlurie/PS-Installers/blob/main/Developer%20Tools/Install_Python_3.ps1)
* [qBittorrent](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/File%20Sharing/Install_qBittorrent.ps1)
* [ShareX](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Imaging/Install_ShareX.ps1)
* [Signal](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Signal.ps1)
* [Skype](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Skype.ps1)
* [Spotify](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_Spotify.ps1)
* [Sublime Text](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Sublime_Text.ps1)
* [Sumatra PDF](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Documents/Install_Sumatra_PDF.ps1)
* [TeamSpeak](https://github.com/tylerlurie/PS-Installers/blob/main/Messaging/Install_TeamSpeak.ps1)
* [Telegram](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Telegram.ps1)
* [Thunderbird](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Thunderbird.ps1)
* [Visual C++ Redistributable (2015-2022)](https://github.com/tylerlurie/PS-Installers/blob/main/Runtimes/Install_VCRedist-x64.ps1)
* [Visual Studio Code](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_Visual_Studio_Code.ps1)
* [Visual Studio Community](https://github.com/tylerlurie/PS-Installers/blob/main/Developer%20Tools/Install_Visual_Studio_Community.ps1)
* [Vivaldi](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Vivaldi.ps1)
* [VLC Media Player](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Media/Install_VLC_Media_Player.ps1)
* [WinRAR](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Compression/Install_WinRAR.ps1)
* [WinSCP](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Developer%20Tools/Install_WinSCP.ps1)
* [Zoom](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Messaging/Install_Zoom.ps1)