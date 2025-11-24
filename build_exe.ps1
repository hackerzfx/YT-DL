# Build Standalone Executable for Windows
# This script creates a standalone .exe that doesn't require Python installation

Write-Host "=======================================" -ForegroundColor Green
Write-Host "   Building Standalone YT-DL.exe" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green
Write-Host ""

# Check Python installation
Write-Host "Checking Python installation..." -ForegroundColor Cyan
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Python is required to BUILD the executable." -ForegroundColor Yellow
    Write-Host "After building, the .exe can run without Python." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Install Python from: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# Install PyInstaller
Write-Host "Installing PyInstaller..." -ForegroundColor Cyan
python -m pip install --upgrade pyinstaller --quiet

# Install yt-dlp (needed for bundling)
Write-Host "Installing yt-dlp..." -ForegroundColor Cyan
python -m pip install --upgrade yt-dlp --quiet

# Build the executable
Write-Host "Building standalone executable..." -ForegroundColor Cyan
Write-Host "This may take a few minutes..." -ForegroundColor Yellow

$buildArgs = @(
    "--onefile",
    "--name=yt-dl",
    "--icon=NONE",
    "--console",
    "yd.py"
)

pyinstaller $buildArgs

if (Test-Path "dist\yt-dl.exe") {
    Write-Host ""
    Write-Host "=======================================" -ForegroundColor Green
    Write-Host "         Build Successful!" -ForegroundColor Green
    Write-Host "=======================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Executable created: dist\yt-dl.exe" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "IMPORTANT: You still need ffmpeg installed!" -ForegroundColor Yellow
    Write-Host "Install ffmpeg: winget install ffmpeg" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Cyan
    Write-Host "  .\dist\yt-dl.exe" -ForegroundColor White
    Write-Host "  .\dist\yt-dl.exe <URL>" -ForegroundColor White
    Write-Host ""
    Write-Host "You can copy yt-dl.exe anywhere and run it without Python!" -ForegroundColor Green
    
    # Cleanup build files
    $response = Read-Host "Clean up build files? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Remove-Item -Recurse -Force "build" -ErrorAction SilentlyContinue
        Remove-Item -Force "yt-dl.spec" -ErrorAction SilentlyContinue
        Write-Host "✓ Build files cleaned" -ForegroundColor Green
    }
} else {
    Write-Host "✗ Build failed!" -ForegroundColor Red
    exit 1
}
