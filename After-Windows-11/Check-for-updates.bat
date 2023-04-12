@echo off
Title Check for apps updates

:: Winget
powershell -command "winget upgrade -i -r"

:: Scoop
powershell -command "scoop update -k -q -a"

pause