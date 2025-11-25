#!/usr/bin/env python3
"""
YT-DL - Cross-Platform YouTube Downloader
Works on Windows, Linux, macOS, and Termux
Developer: Ali Hamza "HaCKeRZ"
"""

import os
import sys
import subprocess
import platform
import re
from pathlib import Path


def clear_screen():
    """Clear the terminal screen."""
    os.system('cls' if os.name == 'nt' else 'clear')


def get_output_directory():
    """Get the appropriate output directory based on the platform."""
    system = platform.system()
    
    if system == "Windows":
        # Windows: Use Videos folder
        videos_dir = Path.home() / "Videos" / "YTDLP"
    elif os.path.exists("/sdcard"):
        # Termux/Android
        videos_dir = Path("/sdcard/YTDLP")
    else:
        # Linux/macOS
        videos_dir = Path.home() / "Videos" / "YTDLP"
    
    # Create directory if it doesn't exist
    videos_dir.mkdir(parents=True, exist_ok=True)
    return videos_dir


def is_playlist_url(url):
    """Check if the URL is a playlist."""
    return bool(re.search(r'(list=|playlist\?)', url))


def print_header():
    """Print the application header."""
    clear_screen()
    print("=" * 40)
    print("              YT-DL")
    print("-" * 40)
    print('   Developer: Ali Hamza "user : HaCKeRZ"')
    print("=" * 40)
    print()


def get_url():
    """Get URL from user input or command line argument."""
    if len(sys.argv) > 1:
        return sys.argv[1]
    else:
        url = input("Paste YouTube video/playlist URL: ").strip()
        return url


def get_playlist_choice():
    """Ask user if they want to download entire playlist or single video."""
    print()
    print("Playlist detected!")
    while True:
        choice = input("Download entire playlist? (y/n): ").strip().lower()
        if choice in ['y', 'yes']:
            return "--yes-playlist"
        elif choice in ['n', 'no']:
            return "--no-playlist"
        else:
            print("Invalid option. Please enter y or n.")


def get_quality_choice():
    """Get quality selection from user."""
    print()
    print("Select quality:")
    print("1) 1080p")
    print("2) 720p")
    print("3) 480p")
    print("4) 360p")
    print("5) MP3")
    
    while True:
        choice = input("Option (1-5): ").strip()
        
        if choice == "1":
            return ['-f', 'bestvideo[height<=1080]+bestaudio', '--merge-output-format', 'mp4']
        elif choice == "2":
            return ['-f', 'bestvideo[height<=720]+bestaudio', '--merge-output-format', 'mp4']
        elif choice == "3":
            return ['-f', 'bestvideo[height<=480]+bestaudio', '--merge-output-format', 'mp4']
        elif choice == "4":
            return ['-f', 'bestvideo[height<=360]+bestaudio', '--merge-output-format', 'mp4']
        elif choice == "5":
            return ['--extract-audio', '--audio-format', 'mp3']
        else:
            print("Invalid option. Please choose 1-5.")


def check_ytdlp():
    """Check if yt-dlp is installed."""
    try:
        subprocess.run(['yt-dlp', '--version'], 
                      capture_output=True, 
                      check=True)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False


def main():
    """Main function."""
    print_header()
    
    # Check if yt-dlp is installed
    if not check_ytdlp():
        print("ERROR: yt-dlp is not installed!")
        print()
        if os.name == 'nt':
            print("Please run: setup.ps1")
        else:
            print("Please run: bash setup.sh")
        sys.exit(1)
    
    # Get URL
    url = get_url()
    if not url:
        print("No URL provided.")
        sys.exit(1)
    
    # Check for playlist
    playlist_opts = []
    if is_playlist_url(url):
        playlist_opt = get_playlist_choice()
        playlist_opts.append(playlist_opt)
    
    # Get quality choice
    quality_opts = get_quality_choice()
    
    # Get output directory
    output_dir = get_output_directory()
    output_template = str(output_dir / "%(title)s.%(ext)s")
    
    # Build command
    cmd = ['yt-dlp', '--newline']
    cmd.extend(playlist_opts)
    cmd.extend(['-o', output_template])
    cmd.extend(quality_opts)
    cmd.append(url)
    
    # Execute download
    print()
    print("Starting...")
    print()
    
    try:
        subprocess.run(cmd, check=True)
        print()
        print(f"Done! Saved to {output_dir}")
        
        # Bell sound (works on most terminals)
        print('\a', end='')
        
    except subprocess.CalledProcessError as e:
        print()
        print(f"Error during download: {e}")
        sys.exit(1)
    except KeyboardInterrupt:
        print()
        print("Download cancelled by user.")
        sys.exit(1)


if __name__ == "__main__":
    main()
