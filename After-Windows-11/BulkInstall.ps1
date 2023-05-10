<#
.SYNOPSIS
    Bulk apps installer for lazy person.
.DESCRIPTION
    Installing Apps, Dependency, Extensions using winget and scoop package manager.
.NOTES
    This is my personal preference. so be sure to change before run this script.
    Place the "#" char before function if you don't want to run it
    Tested on 'Windows 11 Enterprise'
.LINK
    https://github.com/semisoft0072/Configuration/tree/main/After-Windows-11
#>

# Title
$Host.UI.RawUI.WindowTitle = "BulkInstall"
Write-Host "This is my personal preference. so be sure to change before run this script." -ForegroundColor Red
Read-Host -Prompt "Press any key to start"

# Updating Source Winget
Write-Host "Updating winget..." -ForegroundColor Yellow
winget source update
# Updating Scoop
Write-Host "Updating Scoop..." -ForegroundColor Yellow
# Scoop uses Git to update itself.
scoop install git
# Scoop uses aria2c for multi-connection downloads.
scoop install aria2
# To disable aria2 warning
scoop config aria2-warning-enabled false
# Update apps, or Scoop itself
scoop update
# Updating Adding Scoop Buckets
"`n"
Write-Host "Adding Buckets..." -ForegroundColor Yellow `n
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
scoop bucket add java
scoop bucket add missing-apps https://github.com/semisoft0072/scoop-apps
"`n"

# Winget AppList
$WingetList = @(
    # Microsoft Store Apps
    "9PFHDD62MXS1", # Apple Music Preview
    "9PJSDV0VPK04", # Bitwarden
    "XP8C9QZMS2PC1T", # Brave Browser
    "9PGCV4V3BK4W", # DevToys
    "XPDC2RH70K22MN", # Discord
    "XP99VR1BPSBQJ2", # Epic Games Launcher
    "9WZDNCRFJ2WL", # Facebook
    "9WZDNCRF0083", # Facebook Messenger
    "9NBLGGH5L9XT", # Instagram
    "XP89DCGQ3K6VLD", # Microsoft PowerToys
    "9NBLGGH5R558", # Microsoft To Do
    "9NVMNJCR03XV", # MSI Center
    "9N8G7TSCL18R", # NanaZip
    "9NF8H0H7WMLT", # NVIDIA Control Panel
    "9MZ1SNWT0N5D", # PowerShell
    "9NRWMJP3717K", # Python 3.11
    "9NS3RBQ5HV5F", # Reddit
    "9NCBCSZSJRSB", # Spotify
    "9WZDNCRFJ140", # Twitter
    "XP9KHM4BK9FZ7Q", # Visual Studio Code
    "9NKSQGP7F2NH", # WhatsApp
    "9MSVKQC78PK6", # WSL Debian
    # Apps , Dependency
    "Cloudflare.Warp", # Cloudflare WARP
    "clsid2.mpc-hc", # MPC-HC
    "GitHub.GitHubDesktop", # GitHub Desktop
    "Google.Drive", # Google Drive for desktop
    "Henry++.simplewall", # simplewall
    "JetBrains.Toolbox", # JetBrains Toolbox
    "Microsoft.DirectX" # DirectX End-User Runtime Web Installer
    "Microsoft.DotNet.DesktopRuntime.7", # Microsoft .NET Windows Desktop Runtime 7.0
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
    "qBittorrent.qBittorrent", # qBittorrent
    "Telegram.TelegramDesktop", # Telegram Desktop
    "Valve.Steam", # Steam
    "voidtools.Everything" # Everything
)
ForEach ($WingetID in $WingetList) {
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "winget install --id $WingetID -e"                         -ForegroundColor Gray
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    winget install --id $WingetID -e --accept-source-agreements --accept-package-agreements
    "`n"
}

# Scoop AppList
$ScoopList = @(
    # Checkup Dependency
    "dark", # WiX (Windows Installer XML) Toolset Decompiler
    "innounp", # Inno Setup Unpacker
    "wixtoolset", # WiX Toolset
    # Apps
    "adb", # Android SDK platform-tools
    "aria2", # Aria2
    "deew", # Dolby Encoding Engine Wrapper
    "drivedlgo", #Drive-Dl-Go
    "fancontrol", # Fan Control
    "ffmpeg-nightly", # FFmpeg Master BtbN builds
    "freetube", # FreeTube
    "gMKVExtractGUI", # gMKVExtractGUI
    "gpac", # MP4Box
    "imageglass", # ImageGlass
    "jdownloader", # JDownloader
    "keepass" # KeePass Password Safe
    "MakeMKV", # MakeMKV
    "mediainfo", # MediaInfo-CLI
    "mediainfo-gui", # MediaInfo-GUI
    "MKVmergeBatcher", # MKVmergeBatcher
    "mkvtoolnix", # MKVToolNix
    "mpc-hc-fork", # 
    "picocrypt", # Picocrypt
    "qaac", # CLI QuickTime AAC/ALAC encoder
    "rclone" # Rclone
    "rclone-browser", # RcloneBrowser
    "sox", # SoX - Sound eXchange
    "staxrip", # Staxrip
    "subtitleedit", # Subtitle Edit
    "temurin8-jre" # Java OpenJDK
    "tor-browser", # Tor Browser
    "winmerge", # WinMerge
    "yt-dlp" # YT-DLP
    #"freac", # fre:ac - free audio converter
    #"hakuneko", # HakuNeko Desktop
)
ForEach ($ScoopID in $ScoopList) {
    Write-Host "-----------------------------" -ForegroundColor DarkGray
    Write-Host "scoop install $ScoopID"        -ForegroundColor Gray
    Write-Host "-----------------------------" -ForegroundColor DarkGray
    scoop install $ScoopID
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
    "tldr" # tldr-pages
    #"ffsubsync", # FFsubsync
)
ForEach ($PipID in $PipList) {
    Write-Host "---------------------" -ForegroundColor DarkGray
    Write-Host "pip install $PipID"    -ForegroundColor Gray
    Write-Host "---------------------" -ForegroundColor DarkGray
    pip install $PipID
    "`n"
}

# Visual Studio Code extensions list
$VSCEList = @(
    "aaron-bond.better-comments" # Better Comments
    "DavidAnson.vscode-markdownlint" # markdownlint
    "eamodio.gitlens" # GitLens — Git supercharged
    "EditorConfig.EditorConfig" # EditorConfig for VS Code
    "esbenp.prettier-vscode" # Prettier - Code formatter
    "formulahendry.code-runner" # Code Runner
    "GitHub.github-vscode-theme" # GitHub Theme
    "MichaelZhou.fleet-theme" # Jetbrains Fleet Theme
    "ms-python.python" # Python
    "ms-python.vscode-pylance" # Pylance
    "ms-toolsai.jupyter" # Jupyter
    "ms-toolsai.jupyter-keymap" # Jupyter Keymap
    "ms-toolsai.jupyter-renderers" # Jupyter Notebook Renderers
    "ms-toolsai.vscode-jupyter-cell-tags" # Jupyter Call Tags
    "ms-toolsai.vscode-jupyter-slideshow" # Jupyter Slide Show
    "ms-vscode-remote.remote-wsl" # WSL
    "ms-vscode.cpptools" # C/C++
    "ms-vscode.powershell" # Powershell
    "ShayanAhmedKhan.fleet-color-theme" # Fleet Color Theme
    "streetsidesoftware.code-spell-checker" # Code Spell Checker
    "vscode-icons-team.vscode-icons" # vscode-icons
)
ForEach ($VSCEID in $VSCEList) {
    Write-Host "--------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "VSCode --install-extension $VSCEID"                             -ForegroundColor Gray
    Write-Host "--------------------------------------------------------------" -ForegroundColor DarkGray
    code --install-extension $VSCEID
    "`n"
}

# Updating All Apps if found / Check for potential problems and Cleaning Up
Write-Host "Updating App if found / Check for potential problems and Cleaning Up..." -ForegroundColor Yellow
winget upgrade -i -r
scoop update -k -q -a
scoop checkup *
scoop cleanup -a -k
"`n"

Write-Host "`nDone." -ForegroundColor Green
Read-Host -Prompt "Press any key to Exit"