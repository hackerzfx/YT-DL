# Windows Installation Guide

## Prerequisites

### Option 1: Standalone Executable (No Python Required) ⭐ **Easiest**

If you don't want to install Python, you can use the pre-built standalone executable:

1. **Download the latest release**
   - Go to: https://github.com/hackerzfx/YT-DL/releases
   - Download `yt-dl.exe`

2. **Install ffmpeg** (still required)
   ```powershell
   winget install ffmpeg
   ```

3. **Run the executable**
   ```powershell
   yt-dl.exe
   ```

That's it! No Python installation needed.

---

### Option 2: Python Installation (More Flexible)

Before installing YT-DL on Windows, ensure you have:

1. **Python 3.7 or higher**
   - Download from: https://www.python.org/downloads/
   - ⚠️ **IMPORTANT**: Check "Add Python to PATH" during installation

2. **ffmpeg** (required for video merging and MP3 extraction)
   - Install via winget: `winget install ffmpeg`
   - Or via chocolatey: `choco install ffmpeg`
   - Or download manually: https://ffmpeg.org/download.html

---

## Installation Methods

### Method 1: Standalone Executable (Recommended for Non-Developers)

1. **Download the executable**
   - Get `yt-dl.exe` from the releases page
   - Or build it yourself (see "Building Standalone Executable" below)

2. **Install ffmpeg**
   ```powershell
   winget install ffmpeg
   ```

3. **Run it**
   ```powershell
   yt-dl.exe
   ```

**Advantages**:
- ✅ No Python installation required
- ✅ Single file, portable
- ✅ Can run from USB drive
- ✅ Simpler for non-technical users

**Disadvantages**:
- ⚠️ Larger file size (~15-20 MB)
- ⚠️ Still requires ffmpeg

---

### Method 2: Automated Setup with Python

1. **Download or clone the repository**
   ```powershell
   git clone https://github.com/hackerzfx/YT-DL
   cd YT-DL
   ```

2. **Run the PowerShell setup script**
   ```powershell
   powershell -ExecutionPolicy Bypass -File setup.ps1
   ```

3. **Follow the prompts**
   - The script will install yt-dlp
   - Optionally install ffmpeg via winget
   - Create a batch wrapper (`yd.bat`)
   - Optionally add to PATH

4. **Restart your terminal** (if you added to PATH)

---

### Method 3: Manual Setup with Python

1. **Install Python dependencies**
   ```powershell
   python -m pip install --upgrade pip
   python -m pip install --upgrade yt-dlp
   ```

2. **Install ffmpeg**
   ```powershell
   winget install ffmpeg
   ```

3. **Download the repository**
   ```powershell
   git clone https://github.com/hackerzfx/YT-DL
   cd YT-DL
   ```

4. **Run the script**
   ```powershell
   python yd.py
   ```

---

## Building Standalone Executable

If you want to build the `.exe` yourself:

1. **Clone the repository**
   ```powershell
   git clone https://github.com/hackerzfx/YT-DL
   cd YT-DL
   ```

2. **Run the build script**
   ```powershell
   powershell -ExecutionPolicy Bypass -File build_exe.ps1
   ```

3. **Find the executable**
   - Located in: `dist\yt-dl.exe`
   - Copy it anywhere you want

---

## Usage

### Standalone Executable
```powershell
yt-dl.exe
```
or
```powershell
yt-dl.exe "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Python Script
```powershell
yd.bat
```
or
```powershell
python yd.py
```

---

## Features

- ✅ **Single video downloads** (1080p/720p/480p/360p)
- ✅ **MP3 audio extraction**
- ✅ **Playlist support** with automatic detection
- ✅ **Progress display** during downloads
- ✅ **Auto-creates** output directory in `Videos\YTDLP`

---

## Troubleshooting

### "Python is not recognized" (Python Method Only)
- Reinstall Python and check "Add Python to PATH"
- Or manually add Python to PATH in System Environment Variables

### "ffmpeg is not recognized"
- Install ffmpeg using one of the methods above
- Verify installation: `ffmpeg -version`
- Restart your terminal after installation

### "Execution Policy" Error
Run PowerShell as Administrator and execute:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Downloads fail or show errors
- Update yt-dlp: `python -m pip install --upgrade yt-dlp` (Python method)
- Or download the latest `yt-dl.exe` (Standalone method)
- Check your internet connection
- Verify the URL is correct

### Permission Denied
- Run terminal as Administrator
- Check antivirus isn't blocking the script/executable

### Standalone .exe is too slow to start
- This is normal - the executable unpacks itself on first run
- Subsequent runs will be faster
- For better performance, use the Python method

---

## Output Location

Downloads are saved to:
```
C:\Users\YourUsername\Videos\YTDLP\
```

---

## Uninstallation

### Standalone Executable
1. Delete `yt-dl.exe`
2. Optionally uninstall ffmpeg

### Python Method
1. Remove from PATH (if added)
2. Uninstall yt-dlp: `python -m pip uninstall yt-dlp`
3. Delete the YT-DL folder

---

## Which Method Should I Choose?

| Method | Best For | Pros | Cons |
|--------|----------|------|------|
| **Standalone .exe** | Non-technical users, portable use | No Python needed, single file | Larger size, slower startup |
| **Python Script** | Developers, frequent updates | Faster, smaller, easier to update | Requires Python |

---

## Support

For issues or questions:
- Check the main [README.md](README.md)
- Open an issue on GitHub
- Developer: Ali Hamza "HaCKeRZ"
