<#
Adding/Fixing after apps installation processing done
Place the "#" char before function if you don't want to run it
#>

# Check if the script is running as administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $IsAdmin) {

# Restart the script with administrator privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.InvocationName)`"" -Verb RunAs
    exit
}

# Title
$Host.UI.RawUI.WindowTitle = "Post-Processing"
Write-Host "=====================================" -ForegroundColor DarkGray
Write-Host "Adding/Fixing"                         -ForegroundColor Red
Write-Host "Note: This is my personal preference." -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor DarkGray
"`n"
Read-Host -Prompt "Are You Sure!"

# Enabling Developer Mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
Write-Host "Developer Mode 'On'"
"`n"

# Stop F1 Key from Opening Help (Bing)
reg add "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win32" /ve /t REG_SZ /d "" /f > NUL 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" /ve /t REG_SZ /d "" /f > NUL 2>&1
Write-Host "Disabling 'F1' Key from Opening Help"
"`n"

# File Explorer
Write-Host "File Explorer Settigs for devloper-friendly experience..." -ForegroundColor Yellow
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f > NUL 2>&1
Write-Host "Show file extensions 'On'"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f > NUL 2>&1
Write-Host "Show hidden and system files 'On'"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /F > NUL 2>&1
Write-Host "Show full path in title bar 'On'"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideDrivesWithNoMedia /t REG_DWORD /d 0 /F > NUL 2>&1
Write-Host "Show empty drives 'On'"
"`n"

# Restarting File Explorer
Write-Host "Restarting File Explorer..." -ForegroundColor Yellow
Get-Process explorer | Stop-Process -Force
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
} else {
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