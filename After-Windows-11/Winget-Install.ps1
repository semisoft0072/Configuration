<#
Place the "#" char before function if you don't want to run it
  -i,--interactive  | Request interactive installation; user input may be needed
  -h,--silent       | Request silent installation
#>

# Title
$Host.UI.RawUI.WindowTitle = "winget-Install"
Write-Host "=====================================" -ForegroundColor DarkGray
Write-Host "Installing from winget"                -ForegroundColor Red
Write-Host "Note: This is my personal preference." -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor DarkGray
"`n"
Read-Host -Prompt "Are You Sure!"

# Updating Source Winget
Write-Host "Updating winget..." -ForegroundColor Yellow
winget source update
"`n"

# Winget AppList
$WingetList = @(
    # Microsoft Store Apps
    "9PFHDD62MXS1", # Apple Music Preview
    "XP8C9QZMS2PC1T", # Brave Browser
    "9PGCV4V3BK4W", # DevToys
    "9WZDNCRF0083", # Facebook Messenger
    "XP89DCGQ3K6VLD",  # Microsoft PowerToys
    "9NBLGGH5R558", # Microsoft To Do: Lists, Tasks & Reminders
    "9N8G7TSCL18R", # NanaZip
    "9NF8H0H7WMLT", # NVIDIA Control Panel
    "9NCBCSZSJRSB", # Spotify - Music and Podcasts
    "XP9KHM4BK9FZ7Q", # Visual Studio Code
    "9NKSQGP7F2NH", # WhatsApp
    "9MSVKQC78PK6", # WSL Debian

    # Apps , Dependency
    "Bitwarden.Bitwarden", # Bitwarden
    "Cloudflare.Warp", # Cloudflare WARP
    "clsid2.mpc-hc", # MPC-HC
    "Discord.Discord", # Discord
    "DominikReichl.KeePass", # KeePass Password Safe
    "EpicGames.EpicGamesLauncher", # Epic Games Launcher
    "GitHub.GitHubDesktop", # GitHub Desktop
    "Google.Drive", # Google Drive for desktop
    "Henry++.simplewall", # simplewall
    "JetBrains.Toolbox", # JetBrains Toolbox
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
    "namazso.OpenHashTab", # OpenHashTab
    "Nextcloud.NextcloudDesktop", # Nextcloud
    "Notion.Notion", # Notion
    "Nvidia.GeForceExperience", # NVIDIA GeForce Experience
    "Obsidian.Obsidian", # Obsidian
    "Oracle.VirtualBox", # Oracle VM VirtualBox
    "ProtonTechnologies.ProtonVPN", # ProtonVPN
    "Python.Python.3.11" # Python 3.11
    "qBittorrent.qBittorrent", # qBittorrent
    "Telegram.TelegramDesktop", # Telegram Desktop
    "Valve.Steam", # Steam
    "voidtools.Everything" # Everything
)

# Winget each app
ForEach ($AppID in $WingetList) {
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "winget install --id $AppID -e"                            -ForegroundColor Gray
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    winget install --id $AppID -e --accept-source-agreements --accept-package-agreements
    "`n"
}

# Refreshing Environment Variables
Write-Host "Refreshing Environment Variables..." -ForegroundColor Yellow
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Updating Pip
Write-Host "Updating Pip..." -ForegroundColor Yellow
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
    Write-Host "---------------------" -ForegroundColor DarkGray
    Write-Host "pip install $AppID"    -ForegroundColor Gray
    Write-Host "---------------------" -ForegroundColor DarkGray
    pip install $AppID
    "`n"
}

# Updating All Apps
Write-Host "Updating App if found..." -ForegroundColor Yellow
winget upgrade --all
"`n"

Write-Host "`nDone." -ForegroundColor Green
Read-Host -Prompt "Press any key to Exit"