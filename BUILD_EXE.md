# Building Standalone Executable

This guide explains how to create a standalone `yt-dl.exe` that doesn't require Python installation.

## Why Build a Standalone Executable?

**Advantages**:
- ✅ End users don't need Python installed
- ✅ Single portable file
- ✅ Can run from USB drive
- ✅ Easier distribution

**Disadvantages**:
- ⚠️ Larger file size (~15-20 MB vs ~5 KB for script)
- ⚠️ Still requires ffmpeg
- ⚠️ Slower startup (unpacks on first run)

## Prerequisites for Building

- Python 3.7+ (only needed to BUILD, not to RUN the exe)
- PyInstaller
- yt-dlp

## Build Instructions

### Automated Build (Recommended)

```powershell
# Clone the repository
git clone https://github.com/hackerzfx/YT-DL
cd YT-DL

# Run the build script
powershell -ExecutionPolicy Bypass -File build_exe.ps1
```

The executable will be created in `dist\yt-dl.exe`.

### Manual Build

```powershell
# Install dependencies
python -m pip install --upgrade pyinstaller yt-dlp

# Build the executable
pyinstaller --onefile --name=yt-dl --console yd.py

# Find the executable
# Located in: dist\yt-dl.exe
```

## Distribution

After building:

1. The executable is in `dist\yt-dl.exe`
2. Copy it anywhere you want
3. Share it with others (they don't need Python!)
4. Users still need ffmpeg installed

## Creating a Release

To create a GitHub release with the executable:

1. Build the executable
2. Create a new release on GitHub
3. Upload `dist\yt-dl.exe` as a release asset
4. Users can download and run without Python

## Notes

- The executable bundles Python and yt-dlp together
- It extracts to a temporary directory on each run
- First run may be slower due to extraction
- Antivirus may flag it (false positive) - you can sign the exe to avoid this
- The exe is platform-specific (Windows only)

## Troubleshooting Build Issues

### "PyInstaller not found"
```powershell
python -m pip install --upgrade pyinstaller
```

### "Module not found" errors
```powershell
python -m pip install --upgrade yt-dlp
```

### Large executable size
This is normal. PyInstaller bundles Python runtime and all dependencies.

### Antivirus blocks the exe
- This is a false positive
- You can sign the executable with a code signing certificate
- Or add an exception in your antivirus
