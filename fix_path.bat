@echo off
REM Batch script to add Pub Cache bin to PATH
REM Run this script as Administrator

set "PUB_CACHE_BIN=%USERPROFILE%\AppData\Local\Pub\Cache\bin"

REM Check if already in PATH
echo %PATH% | findstr /C:"%PUB_CACHE_BIN%" >nul
if %errorlevel% equ 0 (
    echo Pub Cache bin is already in PATH
    goto :verify
)

REM Add to PATH
setx PATH "%PATH%;%PUB_CACHE_BIN%" /M
if %errorlevel% equ 0 (
    echo Successfully added %PUB_CACHE_BIN% to system PATH
    echo Please restart your terminal/Command Prompt for changes to take effect
) else (
    echo Failed to add to PATH. Please run as Administrator.
)

:verify
REM Verify flutterfire is available
flutterfire --version >nul 2>&1
if %errorlevel% equ 0 (
    echo FlutterFire CLI is working!
    flutterfire --version
) else (
    echo FlutterFire CLI not found in PATH. Please restart terminal after running this script.
)

pause