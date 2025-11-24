# YT-DL Windows Setup - Fast Installation
# Developer: Ali Hamza "HaCKeRZ"

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "    YT-DL Fast Setup (Windows)" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

# Quick Python check
Write-Host "[1/4] Checking Python..." -NoNewline
try {
    python --version 2>&1 | Out-Null
    Write-Host " ✓" -ForegroundColor Green
} catch {
    Write-Host " ✗" -ForegroundColor Red
    Write-Host "`nPython not found! Install from: https://python.org/downloads" -ForegroundColor Yellow
    Write-Host "Make sure to check 'Add Python to PATH'`n" -ForegroundColor Yellow
    exit 1
}

# Fast pip + yt-dlp install
Write-Host "[2/4] Installing yt-dlp..." -NoNewline
python -m pip install --upgrade --quiet pip yt-dlp 2>&1 | Out-Null
Write-Host " ✓" -ForegroundColor Green

# Quick ffmpeg check
Write-Host "[3/4] Checking ffmpeg..." -NoNewline
try {
    ffmpeg -version 2>&1 | Out-Null
    Write-Host " ✓" -ForegroundColor Green
} catch {
    Write-Host " ✗" -ForegroundColor Yellow
    Write-Host "`n    Install ffmpeg: winget install ffmpeg" -ForegroundColor Cyan
    Write-Host "    (Required for video merging & MP3)`n" -ForegroundColor Gray
}

# Setup
Write-Host "[4/4] Setting up..." -NoNewline
$outputDir = "$env:USERPROFILE\Videos\YTDLP"
New-Item -ItemType Directory -Path $outputDir -Force 2>&1 | Out-Null

$scriptDir = $PSScriptRoot
$ydScript = Join-Path $scriptDir "yd.py"
$batchFile = Join-Path $scriptDir "yd.bat"

"@echo off`npython `"$ydScript`" %*" | Set-Content -Path $batchFile
Write-Host " ✓" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "         Setup Complete! 🚀" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

Write-Host "Quick Start:" -ForegroundColor Cyan
Write-Host "  yd.bat                    - Start downloading" -ForegroundColor White
Write-Host "  yd.bat <URL>              - Direct download`n" -ForegroundColor White

Write-Host "Downloads save to: $outputDir`n" -ForegroundColor Gray
