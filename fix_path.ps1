# PowerShell script to add Pub Cache bin to PATH
# Run this script as Administrator

$pubCacheBin = "$env:USERPROFILE\AppData\Local\Pub\Cache\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$pubCacheBin*") {
    $newPath = "$currentPath;$pubCacheBin"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Added $pubCacheBin to PATH"
    Write-Host "Please restart your terminal/PowerShell for changes to take effect"
} else {
    Write-Host "Pub Cache bin is already in PATH"
}

# Verify flutterfire is available
try {
    $flutterfireVersion = & flutterfire --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "FlutterFire CLI is working: $flutterfireVersion"
    } else {
        Write-Host "FlutterFire CLI installed but not in PATH. Please restart terminal."
    }
} catch {
    Write-Host "FlutterFire CLI not found. Please restart terminal after running this script."
}