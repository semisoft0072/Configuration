<#
.SYNOPSIS
    Bulk apps installer for lazy person.
.DESCRIPTION
    Installing Apps, Dependency, Extensions using winget and scoop package manager.
.NOTES
    This is my personal preference. so be sure to change before run this script.
    Place the "#" char before function if you don't want to run it
    Tested on 'Windows 11'
.LINK
    https://github.com/semisoft0072/Configuration/tree/main/After-Windows-11
#>

# Title
$Host.UI.RawUI.WindowTitle = "BulkInstall"
Write-Host "This is my personal preference. so be sure to change before run this script." -ForegroundColor Red
Read-Host -Prompt "Press any key to start"

Write-Host "Installing scoop package manager..." -ForegroundColor Yellow
irm get.scoop.sh | iex
"`n"
Write-Host "Accepting source agreements..." -ForegroundColor Yellow
winget install --id --force --accept-source-agreements --accept-package-agreements | out-null
"`n"
Write-Host "Updating winget..." -ForegroundColor Yellow
winget source update
Write-Host "Updating scoop..." -ForegroundColor Yellow
scoop install git -k -a 64bit # scoop uses Git to update itself.
scoop install aria2 -k -a 64bit # scoop uses aria2c for multi-connection downloads.
scoop config aria2-warning-enabled false # To disable aria2 warning
scoop config show_update_log false # Do not show changed commits on 'scoop update'
scoop update
"`n"
Write-Host "Adding Buckets..." -ForegroundColor Yellow
scoop bucket add extras
scoop bucket add java
scoop bucket add versions
scoop bucket add missing-apps https://github.com/semisoft0072/scoop-apps
"`n"

# Winget AppList
$WingetList = @(
    # Microsoft Store Apps
    "9MSVKQC78PK6", # WSL Debian
    "9MZ1SNWT0N5D", # PowerShell
    "9N8G7TSCL18R", # NanaZip
    "9NCBCSZSJRSB", # Spotify
    "9NKSQGP7F2NH", # WhatsApp
    "9NRWMJP3717K", # Python 3.11
    "9NZTWSQNTD0S", # Telegram Desktop
    "9PFHDD62MXS1", # Apple Music Preview
    "9PGCV4V3BK4W", # DevToys
    "9PJSDV0VPK04", # Bitwarden
    "9WZDNCRF0083", # Facebook Messenger
    "XP9KHM4BK9FZ7Q", # Visual Studio Code
    "XP89DCGQ3K6VLD", # Microsoft PowerToys
    "XP99VR1BPSBQJ2", # Epic Games Launcher
    "XPDC2RH70K22MN", # Discord
    # Apps , Dependency
    "Cloudflare.Warp", # Cloudflare WARP
    "GitHub.GitHubDesktop", # GitHub Desktop
    "JetBrains.Toolbox", # JetBrains Toolbox
    "Microsoft.DirectX", # DirectX End-User Runtime Web Installer
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
    "Nvidia.GeForceExperience", # NVIDIA GeForce Experience
    "Obsidian.Obsidian", # Obsidian
    "qBittorrent.qBittorrent", # qBittorrent
    "Valve.Steam" # Steam
)
ForEach ($WingetID in $WingetList) {
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "winget install --id $WingetID"                            -ForegroundColor Gray
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    winget install --id $WingetID -e --accept-source-agreements --accept-package-agreements
    "`n"
}
    
# scoop AppList
$scoopList = @(
    # Checkup Dependency
    "innounp", # Inno Setup Unpacker
    "wixtoolset", # WiX Toolset
    #"dark", # WiX (Windows Installer XML) Toolset Decompiler
    # Apps
    "aria2", # Aria2
    "deew", # Dolby Encoding Engine Wrapper
    "drivedlgo", #Drive-Dl-Go
    "everything", # Everything
    "fancontrol", # Fan Control
    "ffmpeg-nightly", # FFmpeg Master BtbN builds
    "gclone", # gclone
    "gMKVExtractGUI", # gMKVExtractGUI
    "gpac", # MP4Box
    "jdownloader", # JDownloader
    "keepass", # KeePass Password Safe
    "MakeMKV", # MakeMKV
    "mediainfo-gui", # MediaInfo-GUI
    "mkvtoolnix", # MKVToolNix
    "mpc-hc-fork", # MPC-HC
    "mpc-video-renderer", # MPC Video Renderer
    "picocrypt", # Picocrypt
    "qaac", # QuickTime AAC/ALAC encoder
    "rclone", # Rclone
    "rclone-browser", # RcloneBrowser
    "simplewall", # simplewall
    "sox", # SoX - Sound eXchange
    "spek-beta", # Spek
    "staxrip", # Staxrip
    "subtitleedit", # Subtitle Edit
    "temurin8-jre", # Java OpenJDK
    "tor-browser", # Tor Browser
    "winmerge", # WinMerge
    "yt-dlp" # YT-DLP
    #"adb", # Android SDK platform-tools
    #"freac", # fre:ac - free audio converter
    #"hakuneko", # HakuNeko Desktop
)
ForEach ($scoopID in $ScoopList) {
    Write-Host "-----------------------------" -ForegroundColor DarkGray
    Write-Host "scoop install $scoopID"        -ForegroundColor Gray
    Write-Host "-----------------------------" -ForegroundColor DarkGray
    scoop install $scoopID -k -a 64bit
    "`n"
}

# Refreshing Environment Variables
Write-Host "Refreshing Environment Variables..." -ForegroundColor Yellow
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Updating Pip
Write-Host "Updating Pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip
"`n"

# Pip AppList
$PipList = @(
    "tldr" # tldr-pages
    #"plotbitrate" # PlotBitrate
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
    "aaron-bond.better-comments", # Better Comments
    "DavidAnson.vscode-markdownlint", # markdownlint
    "EditorConfig.EditorConfig", # EditorConfig for VS Code
    "ms-python.python", # Python
    "ms-vscode-remote.remote-wsl", # WSL
    "ms-vscode.cpptools", # C/C++
    "ms-vscode.powershell", # Powershell
    "PKief.material-icon-theme", # Material Icon Theme
    "redhat.vscode-xml", # Red Hat XML
    "redhat.vscode-yaml", # Red Hat YAML
    "ShayanAhmedKhan.fleet-color-theme", # Fleet Color Theme
    "streetsidesoftware.code-spell-checker" # Code Spell Checker
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
winget upgrade -i -r -u
scoop update -k -q -a
scoop cleanup -a -k
scoop checkup *
"`n"

Write-Host "Done." -ForegroundColor Green
Read-Host -Prompt "Press any key to Exit"