#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

GREEN=$(printf '\033[1;32m')
YELLOW=$(printf '\033[1;33m')
RED=$(printf '\033[1;31m')
RESET=$(printf '\033[0m')

echo "${GREEN}YT-DL Auto-Setup Started...${RESET}"

pkg update -y >/dev/null 2>&1 || true
pkg upgrade -y >/dev/null 2>&1 || true

pkg install -y python ffmpeg git wget curl dos2unix >/dev/null 2>&1 || true

python -m ensurepip --upgrade >/dev/null 2>&1 || true
python -m pip install --upgrade pip >/dev/null 2>&1 || true

if ! command -v yt-dlp >/dev/null 2>&1; then
    pkg install -y yt-dlp >/dev/null 2>&1 || true
fi

if ! command -v yt-dlp >/dev/null 2>&1; then
    python -m pip install --upgrade yt-dlp >/dev/null 2>&1
fi

if ! command -v yt-dlp >/dev/null 2>&1; then
    echo "${RED}yt-dlp install failed.${RESET}"
    exit 1
fi

echo "${GREEN}yt-dlp installed successfully.${RESET}"

OUT_DIR="/sdcard/YTDLP"
mkdir -p "$OUT_DIR" >/dev/null 2>&1 || true

cat > ~/yd <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

clear
echo "======================================="
echo "              YT-DL"
echo "---------------------------------------"
echo "   Developer: Ali Hamza  \"user : HaCKeRZ\""
echo "======================================="

OUT_DIR="/sdcard/YTDLP"
mkdir -p "$OUT_DIR" >/dev/null 2>&1 || true

if [ -z "${1-}" ]; then
  read -p "Paste Only Youtube video URL: " url
else
  url="$1"
fi

[ -n "$url" ] || { echo "No URL provided."; exit 1; }

echo "Select quality:"
echo "1) 1080p"
echo "2) 720p"
echo "3) 480p"
echo "4) 360p"
echo "5) MP3"
read -p "Option (1-5): " choice

case "$choice" in
  1) OPTS='-f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4' ;;
  2) OPTS='-f "bestvideo[height<=720]+bestaudio" --merge-output-format mp4' ;;
  3) OPTS='-f "bestvideo[height<=480]+bestaudio" --merge-output-format mp4' ;;
  4) OPTS='-f "bestvideo[height<=360]+bestaudio" --merge-output-format mp4' ;;
  5) OPTS='--extract-audio --audio-format mp3' ;;
  *) echo "Invalid option."; exit 1 ;;
esac

OUT_TEMPLATE="$OUT_DIR/%(title)s.%(ext)s"
CMD="yt-dlp --newline -o \"$OUT_TEMPLATE\" $OPTS \"$url\""

echo "Starting..."

bash -c "$CMD" 2>&1 | while IFS= read -r line; do
  clean=$(printf "%s" "$line" | sed -r 's/\x1B\[[0-9;]*[A-Za-z]//g')
  printf "\r\033[K%s" "$clean"
done
echo

printf "\nDone! Saved to $OUT_DIR\n"
printf '\a'
EOF

# add alias to bashrc/profile if missing
grep -qxF "alias dl='bash ~/yd'" ~/.bashrc 2>/dev/null || echo "alias dl='bash ~/yd'" >> ~/.bashrc
grep -qxF "alias dl='bash ~/yd'" ~/.profile 2>/dev/null || echo "alias dl='bash ~/yd'" >> ~/.profile

# load aliases now
source ~/.bashrc 2>/dev/null || source ~/.profile 2>/dev/null

# verify
alias dl

chmod +x ~/yd
dos2unix ~/yd >/dev/null 2>&1 || true

if ! grep -qxF "alias dl='bash ~/yd'" ~/.bashrc 2>/dev/null; then echo "alias dl='bash ~/yd'" >> ~/.bashrc; fi
if ! grep -qxF "alias dl='bash ~/yd'" ~/.profile 2>/dev/null; then echo "alias dl='bash ~/yd'" >> ~/.profile; fi

echo "${GREEN}Setup complete! Use: dl <URL>${RESET}"
# add alias to bashrc/profile if missing
grep -qxF "alias dl='bash ~/yd'" ~/.bashrc 2>/dev/null || echo "alias dl='bash ~/yd'" >> ~/.bashrc
grep -qxF "alias dl='bash ~/yd'" ~/.profile 2>/dev/null || echo "alias dl='bash ~/yd'" >> ~/.profile

# load aliases now
source ~/.bashrc 2>/dev/null || source ~/.profile 2>/dev/null
# verify
alias dl
exit -y
