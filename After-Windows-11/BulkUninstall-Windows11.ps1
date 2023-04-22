<#
.SYNOPSIS
    Bulk apps uninstaller for lazy person.
.DESCRIPTION
    Uninstalling Pre-installed apps using winget package manager.
.NOTES
    This is my personal preference. so be sure to change before run this script.
    Place the "#" char before function if you don't want to run it
    Tested on 'Windows 11'
.LINK
    https://github.com/semisoft0072/Configuration/tree/main/After-Windows-11
#>

# Check if the script is running as administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $IsAdmin) {
# Restart the script with administrator privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.InvocationName)`"" -Verb RunAs
    exit
}

# Title
$Host.UI.RawUI.WindowTitle = "BulkUninstall"
Write-Host "This is my personal preference. so be sure to change before run this script." -ForegroundColor Red
Read-Host -Prompt "Press any key to start"

# Pre-installed apps list
$List = @(
    "Clipchamp.Clipchamp_yxz26nhyzhsrt", # Clipchamp - Video Editor
    "Microsoft.549981C3F5F10_8wekyb3d8bbwe", # Cortana
    "Microsoft.BingNews_8wekyb3d8bbwe", # Microsoft News
    "Microsoft.GamingApp_8wekyb3d8bbwe", # Xbox
    "Microsoft.GetHelp_8wekyb3d8bbwe", # Get Help
    "Microsoft.Getstarted_8wekyb3d8bbwe", # Microsoft Tips
    "Microsoft.HEIFImageExtension_8wekyb3d8bbwe", # HEIF Image Extensions
    "Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe", # Office
    "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe", # Solitaire & Casual Games
    "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe", # Microsoft Sticky Notes
    "Microsoft.OneDrive", # Microsoft OneDrive
    "Microsoft.People_8wekyb3d8bbwe", # Microsoft People
    "Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe", # Power Automate
    "Microsoft.RawImageExtension_8wekyb3d8bbwe", # Raw Image Extension
    "Microsoft.Todos_8wekyb3d8bbwe", # Microsoft To Do
    "Microsoft.VP9VideoExtensions_8wekyb3d8bbwe" # VP9 Video Extensions
    "Microsoft.WebMediaExtensions_8wekyb3d8bbwe" # Web Media Extensions
    "Microsoft.WebpImageExtension_8wekyb3d8bbwe" # Webp Image Extensions
    "Microsoft.Windows.Photos_8wekyb3d8bbwe" # Microsoft Photos
    "Microsoft.WindowsCamera_8wekyb3d8bbwe", # Windows Camera
    "microsoft.windowscommunicationsapps_8wekyb3d8bbwe", # Mail and Calendar
    "Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe", # Feedback Hub
    "Microsoft.WindowsMaps_8wekyb3d8bbwe", # Windows Maps
    "Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe", # Windows Voice Recorder
    "Microsoft.Xbox.TCUI_8wekyb3d8bbwe", #Xbox TCUI
    "Microsoft.XboxGameOverlay_8wekyb3d8bbwe", # Xbox Game Bar Plugin
    "Microsoft.XboxIdentityProvider_8wekyb3d8bbwe", # Xbox Identity Provider
    "Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe", # Xbox Game Speech Window
    "Microsoft.YourPhone_8wekyb3d8bbwe" # Your Phone
    "Microsoft.YourPhone_8wekyb3d8bbwe", # Phone Link
    "Microsoft.ZuneMusic_8wekyb3d8bbwe", # Windows Media Player
    "Microsoft.ZuneVideo_8wekyb3d8bbwe", # Movies & TV
    "MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe", # Quick Assist
    "MicrosoftTeams_8wekyb3d8bbwe", # Microsoft Teams
    "MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy", # Windows Web Experience Pack
    "{462f63a8-6347-4894-a1b3-dbfe3a4c981d}" # Microsoft Visual C++ 2015 Redistributable (x86)
)
ForEach ($AppID in $List) {
    Write-Host "-------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "winget uninstall --id $AppID -e"                                     -ForegroundColor Gray
    Write-Host "-------------------------------------------------------------------" -ForegroundColor DarkGray
    winget uninstall --id $AppID -e --force --purge --accept-source-agreements --accept-package-agreements
    "`n"
}

Write-Host "`nDone." -ForegroundColor Green
Read-Host -Prompt "Press any key to Exit"