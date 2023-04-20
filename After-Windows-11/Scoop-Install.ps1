<#
Place the "#" char before function if you don't want to run it
#>

# Title
$Host.UI.RawUI.WindowTitle = "Scoop-install"
Write-Host "=====================================" -ForegroundColor DarkGray
Write-Host "Installing from scoop"                 -ForegroundColor Red
Write-Host "Note: This is my personal preference." -ForegroundColor White
Write-Host "=====================================" -ForegroundColor DarkGray
"`n"
Read-Host -Prompt "Are You Sure!"

# Updating Scoop
Write-Host "Updating Scoop..." -ForegroundColor Yellow `n
# Scoop uses Git to update itself.
scoop install git
# Scoop uses aria2c for multi-connection downloads.
scoop install aria2
# To disable aria2 warning
scoop config aria2-warning-enabled false
# Update apps, or Scoop itself
scoop update

# Updating Adding Scoop Buckets
Write-Host "Adding Buckets..." -ForegroundColor Yellow `n
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

# Scoop Portable AppList
$ScoopUserList = @(
    # Checkup Dependency
    "dark", # WiX (Windows Installer XML) Toolset Decompiler
    "innounp", # Inno Setup Unpacker
    "wixtoolset", # WiX Toolset
    
    # Apps
    "adb", # Android SDK platform-tools
    "aria2", # Aria2
    "fancontrol", # Fan Control
    "ffmpeg-nightly", # FFmpeg Master BtbN builds
    "freetube", # FreeTube
    "gMKVExtractGUI", # gMKVExtractGUI
    "gpac", # MP4Box
    "imageglass", # ImageGlass
    "MakeMKV", # MakeMKV
    "mediainfo", # MediaInfo-CLI
    "mediainfo-gui", # MediaInfo-GUI
    "MKVmergeBatcher", # MKVmergeBatcher
    "mkvtoolnix", # MKVToolNix
    "picocrypt", # Picocrypt
    "qaac", # CLI QuickTime AAC/ALAC encoder
    "rclone" # Rclone
    "sox", # SoX - Sound eXchange
    "staxrip", # Staxrip
    "subtitleedit", # Subtitle Edit
    "tor-browser", # Tor Browser
    "winmerge" # WinMerge
    #"freac", # fre:ac - free audio converter
    #"hakuneko", # HakuNeko Desktop
    #"rclone-browser", # RcloneBrowser
)
ForEach ($UserAppID in $ScoopUserList) {
    Write-Host "-----------------------------" -ForegroundColor DarkGray
    Write-Host "scoop install $UserAppID"      -ForegroundColor Gray
    Write-Host "-----------------------------" -ForegroundColor DarkGray
    scoop install $UserAppID
    "`n"
}

# Updating All Apps if found / Check for potential problems and Cleaning Up
Write-Host "Updating App if found / Check for potential problems and Cleaning Up..." -ForegroundColor Yellow
scoop update *
scoop checkup *
scoop cleanup *
"`n"

Write-Host "`nDone." -ForegroundColor Green
Read-Host -Prompt "Press any key to Exit"