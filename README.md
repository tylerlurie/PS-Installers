# PS-Installers
This repository contains a collection of PowerShell scripts to download and automatically install the latest 64-bit version of a given application. These scripts also delete the installers they download after installations are finished.

## Installations
For the most part, these scripts will download the MSI installers for applications whenever available. EXEs are downloaded for applications that do not support MSIs.

Applications are typically installed for all users whenever possible, and on a per-user basis when system-wide installation is not supported.

Installations are done silently with no setting configurations done in advance. This means most apps include a desktop shortcut by default.

## Currently Included Apps
* [Brave](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Brave.ps1)
* [Firefox](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Firefox.ps1)
* [Google Chrome](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Google_Chrome.ps1)
* [Opera](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Opera.ps1)
* [Vivaldi](https://raw.githubusercontent.com/tylerlurie/PS-Installers/main/Web%20Browsers/Install_Vivaldi.ps1)