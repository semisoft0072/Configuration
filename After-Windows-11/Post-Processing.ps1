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

Write-Host "===========================================" -ForegroundColor DarkGray
Write-Host "Adding/Fixing"                               -ForegroundColor Red
Write-Host "Note      : This is my personal preference." -ForegroundColor White
Write-Host "===========================================" -ForegroundColor DarkGray
"`n"
Read-Host -Prompt "Are You Sure!"

# Stop F1 Key from Opening Help (Bing)
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win32" /VE /T REG_SZ /D "" /F > NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" /VE /T REG_SZ /D "" /F > NUL 2>&1
Write-Host "- Disabling F1 Key from Opening Help"

# File Explorer
Write-Host "| File Explorer Settigs for devloper-friendly experience |" -ForegroundColor Yellow
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f > NUL 2>&1
Write-Host "- Show file extensions 'On'"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f > NUL 2>&1
Write-Host "- Show hidden and system files 'On'"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V FullPath /T REG_DWORD /D 1 /F > NUL 2>&1
Write-Host "- Show full path in title bar 'On'"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V HideDrivesWithNoMedia /T REG_DWORD /D 0 /F > NUL 2>&1
Write-Host "- Show empty drives 'On'"

# Restarting File Explorer
Write-Host "| Restarting File Explorer |" -ForegroundColor Yellow
Get-Process explorer | Stop-Process -Force

# Adding missing shortcut to desktop
Write-Host "| Creating shortcuts |" -ForegroundColor Yellow
# simplewall
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\simplewall.lnk")
$Shortcut.TargetPath = "C:\Program Files\simplewall\simplewall.exe"
$Shortcut.WorkingDirectory = "C:\Program Files\simplewall"
$Shortcut.Save()
Write-Host "- simplewall shortcut created successfully."

# Adding missing apps to Startup
$StartupPath = "C:\Users\user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Write-Host "| Adding missing apps to Startup |" -ForegroundColor Yellow
# Check-for-updates.bat
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
Move-Item -Path "C:\bin\Check-for-updates.bat" -Destination "$StartupPath"
Write-Host "- Check-for-updates.bat successfully added to Startup."
# simplewall
Copy-Item -Path "$Home\Desktop\simplewall.lnk" -Destination "$StartupPath"
Write-Host "- simplewall successfully added to Startup."
# Fan Control
Copy-Item -Path "C:\Users\user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Scoop Apps\FanControl.lnk" -Destination "$StartupPath"
Write-Host "- Fan Control successfully added to Startup."

# Adding apps configs
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/semisoft0072/Configuration/main/After-Windows-11/configs/aria2.conf" -OutFile "C:\Users\user\.config\aria2.conf"