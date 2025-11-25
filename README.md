
<p align="center">
  <b>⚡ Lightning Fast • Cross-Platform • 1080p • MP3 • Playlists</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Developer-Ali%20Hamza%20(HaCKeRZ)-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20Termux-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Version-2.0-lightgrey?style=for-the-badge">
</p>

---

# 🚀 YT-DL - Lightning Fast YouTube Downloader

Download YouTube videos & playlists in **1080p/720p/480p/360p** or extract **MP3 audio**.  
Works on **Windows**, **Linux**, **macOS**, and **Termux (Android)**.

---

# ⚡ Quick Start

## Windows (30 seconds)

```powershell
git clone https://github.com/hackerzfx/YT-DL && cd YT-DL
powershell -ExecutionPolicy Bypass -File setup.ps1
yd.bat
```

## Termux

### Option 1: One-Line Setup (Recommended)
```bash
apt update -y && apt install curl git -y && bash <(curl -s https://raw.githubusercontent.com/hackerzfx/YT-DL/main/setup.sh)
```

### Option 2: Step-by-Step Setup (Manual)
Use this if you prefer to run commands manually:
```bash
termux-setup-storage
apt update -y
apt install git python ffmpeg -y
git clone https://github.com/hackerzfx/YT-DL
cd YT-DL
chmod +x setup.sh
bash setup.sh
```
Then restart Termux and use: `dl`

## Linux / macOS

```bash
git clone https://github.com/hackerzfx/YT-DL && cd YT-DL
bash setup.sh
python3 yd.py
```

---

# 🎯 Features

✅ **1080p/720p/480p/360p** video quality  
✅ **MP3** audio extraction  
✅ **Playlist** auto-detection & download  
✅ **Cross-platform** (Windows/Linux/macOS/Termux)  
✅ **Fast** setup & downloads  

---

# 💡 Usage Examples

### Download a video
```bash
# Windows
yd.bat "https://youtube.com/watch?v=xxxxx"

# Linux/macOS/Termux
python3 yd.py "https://youtube.com/watch?v=xxxxx"
```

### Download a playlist
```bash
# Paste playlist URL when prompted
# Choose: Download entire playlist or single video
# Select quality: 1080p/720p/480p/360p/MP3
```

---

# 📂 Where Files Are Saved

- **Windows**: `C:\Users\YourName\Videos\YTDLP\`
- **Termux**: `/sdcard/YTDLP/`
- **Linux/macOS**: `~/Videos/YTDLP/`

---

# 🔧 Requirements

- **Python 3.7+** (auto-installed on Termux)
- **ffmpeg** (for video merging & MP3)
  - Windows: `winget install ffmpeg`
  - Linux: `apt install ffmpeg`
  - macOS: `brew install ffmpeg`

---

# 👨‍💻 Developer

**Ali Hamza** — *HaCKeRZ*

---

# 📚 More Info

- **Windows Guide**: [INSTALL_WINDOWS.md](INSTALL_WINDOWS.md)
- **Build Executable**: [BUILD_EXE.md](BUILD_EXE.md)
- **Issues**: [GitHub Issues](https://github.com/hackerzfx/YT-DL/issues)
