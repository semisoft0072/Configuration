<#
Installing NonPortable Apps
Place the "#" char before function if you don't want to run it
  -i,--interactive  | Request interactive installation; user input may be needed
  -h,--silent       | Request silent installation
#>

# Check if the script is running as administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $IsAdmin) {

# Restart the script with administrator privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.InvocationName)`"" -Verb RunAs
    exit
}

# Enabling Developer Mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /T REG_DWORD /F /V "AllowDevelopmentWithoutDevLicense" /D "1"

# Title
$Host.UI.RawUI.WindowTitle = "Winget-Install"

Write-Host "===========================================" -ForegroundColor DarkGray
Write-Host "Installing Apps, Dependency"                 -ForegroundColor Red
Write-Host "Note      : This is my personal preference." -ForegroundColor Yellow
Write-Host "===========================================" -ForegroundColor DarkGray
"`n"
Read-Host -Prompt "Are You Sure!"

# Updating Source Winget
Write-Host "| Updating Source Winget |" -ForegroundColor Yellow `n
winget source update
"`n"

# Winget AppList (Non Portable)
$WingetList = @(
    # NVIDIA Driver
    "Nvidia.GeForceExperience", # NVIDIA GeForce Experience
    "9NF8H0H7WMLT", # NVIDIA Control Panel

    # Dependency
    "9MSVKQC78PK6", # WSL Debian
    "Microsoft.DirectX" # DirectX End-User Runtime Web Installer
    "Microsoft.DotNet.DesktopRuntime.7", # Microsoft .NET Windows Desktop Runtime 7.0
    "Microsoft.PowerShell", # PowerShell 7
    "Microsoft.VCRedist.2005.x64", # Microsoft Visual C++ 2005 Redistributable (x64)
    "Microsoft.VCRedist.2005.x86", # Microsoft Visual C++ 2005 Redistributable (x86)
    "Microsoft.VCRedist.2008.x64", # Microsoft Visual C++ 2008 Redistributable (x64)
    "Microsoft.VCRedist.2008.x86", # Microsoft Visual C++ 2008 Redistributable (x86)
    "Microsoft.VCRedist.2010.x64", # Microsoft Visual C++ 2010 Redistributable (x64)
    "Microsoft.VCRedist.2010.x86", # Microsoft Visual C++ 2010 Redistributable (x86)
    "Microsoft.VCRedist.2012.x64", # Microsoft Visual C++ 2012 Redistributable (x64)
    "Microsoft.VCRedist.2012.x86", # Microsoft Visual C++ 2012 Redistributable (x86)
    "Microsoft.VCRedist.2013.x64", # Microsoft Visual C++ 2013 Redistributable (x64)
    "Microsoft.VCRedist.2013.x86", # Microsoft Visual C++ 2013 Redistributable (x86)
    "Microsoft.VCRedist.2015+.x64", # Microsoft Visual C++ 2015-2022 Redistributable (x64)
    "Microsoft.VCRedist.2015+.x86", # Microsoft Visual C++ 2015-2022 Redistributable (x86)
    "Python.Python.3.11", # Python 3.11

    # Microsoft Store Apps
    "9NCBCSZSJRSB", # Spotify - Music and Podcasts
    "9NKSQGP7F2NH", # WhatsApp
    "9PFHDD62MXS1", # Apple Music Preview
    "9PGCV4V3BK4W", # DevToys
    "9WZDNCRF0083", # Facebook Messenger
    "XP8C9QZMS2PC1T", # Brave Browser
    "XP9KHM4BK9FZ7Q", # Visual Studio Code
    "XP89DCGQ3K6VLD",  # Microsoft PowerToys
    #"9NBLGGH5R558", # Microsoft To Do: Lists, Tasks & Reminders

    # Apps
    "Bitwarden.Bitwarden", # Bitwarden
    "Cloudflare.Warp", # Cloudflare WARP
    "clsid2.mpc-hc", # MPC-HC
    "Discord.Discord", # Discord
    "DominikReichl.KeePass", # KeePass Password Safe
    "EpicGames.EpicGamesLauncher", # Epic Games Launcher
    #"Ferdium.Ferdium", # Ferdium
    "Google.Drive", # Google Drive for desktop
    "GitHub.GitHubDesktop", # GitHub Desktop
    "JetBrains.Toolbox", # JetBrains Toolbox
    "Henry++.simplewall", # simplewall
    "M2Team.NanaZip", # NanaZip
    "namazso.OpenHashTab", # OpenHashTab
    "Nextcloud.NextcloudDesktop", # Nextcloud
    #"nomacs.nomacs", # nomacs - Image Lounge
    "Notion.Notion", # Notion
    "Obsidian.Obsidian", # Obsidian
    #"OBSProject.OBSStudio" # OBS Studio
    "Oracle.VirtualBox", # Oracle VM VirtualBox
    "ProtonTechnologies.ProtonVPN", # ProtonVPN
    "qBittorrent.qBittorrent", # qBittorrent
    #"Sandboxie.Plus", # Sandboxie-Plus
    "Telegram.TelegramDesktop", # Telegram Desktop
    "Valve.Steam", # Steam
    "voidtools.Everything" # Everything
    #"RiotGames.Valorant.EU" # Valorant - EU
)

# Winget each app
ForEach ($AppID in $WingetList) {
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "winget install --id $AppID -e" -ForegroundColor Gray
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    winget install --id $AppID -e --accept-source-agreements --accept-package-agreements
    "`n"
}

# Refreshing Environment Variables
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Updating Pip
Write-Host "| Updating Pip |" -ForegroundColor Yellow
python -m pip install --upgrade pip
"`n"

# Pip AppList
$PipList = @(
    "yt-dlp", # yt-dlp
    "deew", # Dolby Encoding Engine Wrapper
    "ffsubsync", # FFsubsync
    "tldr" # tldr-pages
)

# Pip each app
ForEach ($AppID in $PipList) {
    Write-Host "---------------------------------------------" -ForegroundColor DarkGray
    Write-Host "pip install $AppID" -ForegroundColor Gray
    Write-Host "---------------------------------------------" -ForegroundColor DarkGray
    pip install $AppID
    "`n"
}

# Updating All Apps
Write-Host "| Updating App if found |" -ForegroundColor Yellow
winget upgrade --all
"`n"

Write-Host "`nDone." -ForegroundColor Green
Read-Host -Prompt "Press any key to Exit"