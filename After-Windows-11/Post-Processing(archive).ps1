<#
.SYNOPSIS
    Adding/Fixing for lazy person.
.DESCRIPTION
    Importing config and changing windows settings.
.NOTES
    This is my personal preference. so be sure to change before run this script.
    Place the "#" char before function if you don't want to run it
    Tested on 'Windows 11'
.LINK
    https://github.com/semisoft0072/Configuration/tree/main/After-Windows-11
    https://www.elevenforum.com/
    https://github.com/TairikuOokami/Windows/
    https://gist.github.com/rad1ke/d8c4121931633eca04ca625d09ff1a11
    https://reg2ps.azurewebsites.net/
    https://git.ameliorated.info/explore/repos
#>

# Check if the script is running as administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $IsAdmin) {
    # Restart the script with administrator privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.InvocationName)`"" -Verb RunAs
    exit
}

$ProgressPreference = "SilentlyContinue"

# Title
$Host.UI.RawUI.WindowTitle = "Post-Processing"
Write-Host "This is my personal preference. so be sure to change before run this script." -ForegroundColor Red
Read-Host -Prompt "Press any key to start"

# * System Settings
Write-Host "Changing System Settings..." -ForegroundColor Yellow
# Power mode
Write-Output "Changing power modes to 'Ultimate Performance'"
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
# Nearby sharing
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "CdpSessionUserAuthzPolicy" -Value "1" -PropertyType Dword -Force | Out-Null | Out-Null
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "NearShareChannelUserAuthzPolicy" -Value "0" -PropertyType Dword -Force | Out-Null | Out-Null
# ! Need to Look after sign out
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "RomeSdkChannelUserAuthzPolicy" -Value "1" -PropertyType Dword -Force | Out-Null | Out-Null
# Clipboard
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Value "0" -PropertyType Dword -Force | Out-Null 
Write-Output "Clipboard history 'Off'"
"`n"

# * Bluetooth & devices
Write-Host "Changing Bluetooth & devices Settings..." -ForegroundColor Yellow
# Disable Bluetooth
# ! hmm not working is setting but work for admin user
Disable-NetAdapter -Name "Bluetooth Network Connection" -Confirm:$false
# Mouse
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Value '0' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Value '0' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Value '0' -PropertyType String -Force | Out-Null
Write-Output "Enhance pointer precision 'Off'"
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseSensitivity' -Value '6' -PropertyType String -Force | Out-Null
Write-Output "Changing sensitivity to '6'"
"`n"

# * Network & Internet
Write-Host "Changing Network & Internet Settings..." -ForegroundColor Yellow
# Ethernet
Set-NetConnectionProfile -Name "Network" -NetworkCategory Private
Write-Output "Ethernet Network profile set to 'Private network'"
"`n"

# * Personalisation
Write-Host "Changing Personalisation Settings..." -ForegroundColor Yellow
# Accent colour
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'AutoColorization' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Accent colour set to 'Automatic'"
# Start
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_Layout' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Start set to 'More Pin'"
Remove-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show recently added apps set to 'Off'"
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoRecentDocsHistory' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show recently opened items in Start, Jump Lists, and File Explorer set to 'Off'"
# Taskbar Items
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'SearchOnTaskbarMode' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Search set to 'Hide'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'HideTaskViewButton' -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideTaskViewButton' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Task View set to 'Off'"
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests' -Name 'value' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh' -Name 'AllowNewsAndInterests' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Widgets set to 'Off'"
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat' -Name 'ChatIcon' -Value 3 -PropertyType DWord -Force | Out-Null
Write-Output "Chat set to 'Off'"
# Taskbar behaviours
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAl' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Taskbar alignment set to 'Left'"
"`n"

# * Apps
Write-Host "Changing Apps Settings..." -ForegroundColor Yellow
# Advanced app settings
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP' -Name 'CdpSessionUserAuthzPolicy' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP' -Name 'RomeSdkChannelUserAuthzPolicy' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Share across devices set to 'Off'"
"`n"

# * Windows features
Write-Host "Changing Windows features Settings..." -ForegroundColor Yellow
Write-Output "Enabling 'Guarded Host'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "HostGuardian" -All | Out-Null
Write-Output "Enabling 'Hyper-V'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "Microsoft-Hyper-V-All" -All | Out-Null
Write-Output "Enabling 'Legacy Components'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "LegacyComponents" -All | Out-Null
Write-Output "Enabling 'Microsoft Defender Application Guard'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "Windows-Defender-ApplicationGuard" -All | Out-Null
Write-Output "Enabling 'Virtual Machine Platform'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "VirtualMachinePlatform" -All | Out-Null
Write-Output "Enabling 'Windows Hypervisor Platfrom'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "HypervisorPlatform" -All | Out-Null
Write-Output "Enabling 'Windows Sandbox'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "Containers-DisposableClientVM" -All | Out-Null
Write-Output "Enabling 'Windows Subsystem for linux'"
Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All | Out-Null
Write-Output "Disabling 'Windows Media Player'"
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName "WindowsMediaPlayer" | Out-Null

# * Time & Language
# Typing
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Input\Settings' -Name 'EnableHwkbTextPrediction' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show text suggestions when typing on physical keyboard set to 'On'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Input\Settings' -Name 'MultilingualEnabled' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Multilingual text suggestions set to 'On'"

# * Privacy & Security
# For developers
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' -Name 'AllowDevelopmentWithoutDevLicense' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Developer Mode set to 'On'"
# File Explorer
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Show file extensions set to 'On'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show hidden and system files set to 'On'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState' -Name 'FullPath' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show full path in title bar set to 'On'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'ShowRunAsDifferentUserInStart' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show Option to run as different user in start set to 'On'"
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideDrivesWithNoMedia' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Show empty drives set to 'On'"
# General
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name 'Enabled' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\AdvertisingInfo' -Name 'Value' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Let apps show me personalised ads by using my advertising ID set to 'Off'"
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\International\User Profile' -Name 'HttpAcceptLanguageOptOut' -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "Let websites show me locally relevant content by accessing my language list set to 'Off'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackProgs' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Let Windows improve Start and search results by tracking app launches set to 'Off'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338393Enabled' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353694Enabled' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353696Enabled' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Show me suggested content in the Settings app set to 'Off'"
# Inking & typing personalisation
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization' -Name 'Value' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\InputPersonalization' -Name 'RestrictImplicitInkCollection' -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\InputPersonalization' -Name 'RestrictImplicitTextCollection' -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' -Name 'HarvestContacts' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Customised inking and typing dictionary set to 'Off'"
# Search permissions
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings' -Name 'SafeSearchMode' -Value 2 -PropertyType DWord -Force | Out-Null
Write-Output "SafeSearch set to 'Strict'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name 'IsAADCloudSearchEnabled' -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name 'IsMSACloudSearchEnabled' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Cloud content search Microsoft account and Work or School account set to 'Off'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name 'IsDeviceSearchHistoryEnabled' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Search history on this device set to 'Off'"
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name 'IsDynamicSearchBoxEnabled' -Value 0 -PropertyType DWord -Force | Out-Null
Write-Output "Show search highlight set to 'Off'"
# Camera
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access your camera set to 'Off'"
# Contacts
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access your contacts set to 'Off'"
# Calendar
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access your calendar set to 'Off'"
# Phone calls
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access your phone calls set to 'Off'"
# Call history
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access your call history set to 'Off'"
# Email
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access your email set to 'Off'"
# Messaging
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps read messages set to 'Off'"
# Radios
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps control device radios set to 'Off'"
# Other devices
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Communicate with unpaired devices set to 'Off'"
# App diagnostics
New-ItemProperty -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics' -Name 'Value' -Value 'Deny' -PropertyType String -Force | Out-Null
Write-Output "Let apps access diagnostic info about your other apps set to 'Off'"
"`n"

# * Others
# Stop F1 Key from Opening Help
Write-Host "Disabling 'F1' Key from Opening Help"
if ((Test-Path -LiteralPath "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win32") -ne $true) { New-Item "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win32" -force };
if ((Test-Path -LiteralPath "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64") -ne $true) { New-Item "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" -force };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win32' -Name '(default)' -Value '' -PropertyType String -Force | Out-Null
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64' -Name '(default)' -Value '' -PropertyType String -Force | Out-Null
# TODO: More Staff add soon
"`n"

# Restarting File Explorer
Write-Host "Restarting File Explorer..." -ForegroundColor Yellow
Get-Process explorer | Stop-Process -Force | Out-Null
"`n"

# User folder location
$UserFolder = [System.Environment]::GetFolderPath('UserProfile')
# Adding apps configs
Write-Host "Importing Configs..." -ForegroundColor Yellow
# aria2
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/Configs/Apps/aria2.conf" -OutFile "$UserFolder\.config\aria2.conf"
Write-Host "aria2 config added successfully."
# Fan-Control
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/Configs/Apps/Fan-Control.json" -OutFile "$UserFolder\scoop\apps\fancontrol\current\Configurations\Fan-Control.json"
Write-Host "Fan-Control config added successfully."
# mpc-hc
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/Configs/Apps/mpc-hc.reg" -OutFile "$UserFolder\AppData\Local\Temp\mpc-hc.reg"; reg import "$UserFolder\AppData\Local\Temp\mpc-hc.reg"
Write-Host "mpc-hc config added successfully."
# yt-dlp
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/Configs/Apps/yt-dlp.conf" -OutFile "$UserFolder\AppData\Roaming\yt-dlp\config.txt"
Write-Host "yt-dlp config added successfully."
# Windows-Terminal
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/Configs/Apps/Windows-Terminal.json" -OutFile "$UserFolder\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Write-Host "Windows-Terminal config added successfully."
"`n"

# Adding Check-for-updates.bat to Startup
Write-Host "Adding Check-for-updates.bat to Startup..." -ForegroundColor Yellow
if (!(Test-Path C:\bin)) {
    New-Item -ItemType Directory -Path C:\bin | Out-Null
    Write-Host "Folder created successfully."
}
else {
    Write-Host "Folder already exists: C:\bin"
}
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/After-Windows-11/Check-for-updates.bat" -OutFile "C:\bin\Check-for-updates.bat"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\bin\Check-for-updates.lnk")
$Shortcut.TargetPath = "C:\bin\Check-for-updates.bat"
$Shortcut.WorkingDirectory = "C:\bin"
$Shortcut.Save()
Move-Item -Path "C:\bin\Check-for-updates.bat" -Destination "$UserFolder\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Write-Host "Check-for-updates.bat successfully added to Startup."