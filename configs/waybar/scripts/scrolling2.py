#!/usr/bin/env python3

#    ┏┓┏┓┳┓┏┓┓ ┓ ┳┳┓┏┓  ┏┳┓┏┓┏┓┏┓┏┳┓  ┏┓┏┓┳┓┏┓    ┓
#    ┗┓┃ ┣┫┃┃┃ ┃ ┃┃┃┃┓   ┃ ┣  ┃┃  ┃   ┗┓┃┃┃┃┃┓  ┓┏┃
#    ┗┛┗┛┛┗┗┛┗┛┗┛┻┛┗┗┛   ┻ ┗┛┗┛┗┛ ┻   ┗┛┗┛┛┗┗┛  ┗┛┻
#                                           by Manu

import subprocess
import time
import json
import sys
import signal

# Customization settings (easy to modify)
GLYPH_FONT_FAMILY="Symbols Nerd Font Mono" # Set to your desired symbols font
# Those are glyphs that will be always visible at left side of module.
GLYPHS = {
    "paused": "⏸",
    "playing": "▶",
    "stopped": "⏹"
}
DEFAULT_GLYPH = "▶"  # Glyph when status is unknown or default
TEXT_WHEN_STOPPED = "No music sounds right now"  # Text to display when nothing is playing
SCROLL_TEXT_LENGTH = 25  # Length of the song title part (excludes glyph and space)
REFRESH_INTERVAL = 0.4  # How often the script updates (in seconds)
PLAYERCTL_PATH = "/usr/bin/playerctl" # Path to playerctl, use which playerctl to find yours.


# Function to get player status using playerctl
def get_player_status():
    try:
        result = subprocess.run([PLAYERCTL_PATH, 'status'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        status = result.stdout.decode('utf-8').strip().lower()
        if result.returncode != 0 or not status:
            return "stopped"  # Default to stopped if no status
        return status
    except Exception:
        return "stopped"

# Function to get currently playing song using playerctl
def get_current_song():
    try:
        title_result = subprocess.run([PLAYERCTL_PATH, 'metadata', 'title'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        artist_result = subprocess.run([PLAYERCTL_PATH, 'metadata', 'artist'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        title = title_result.stdout.decode('utf-8').strip()
        artist = artist_result.stdout.decode('utf-8').strip()

        if title_result.returncode != 0 or not title:
            return None

        if artist_result.returncode == 0 and artist:
            return f"{artist} - {title}"
        else:
            return title
    except Exception:
        return None

# Function to generate scrolling text with fixed length
def scroll_text(text, length=SCROLL_TEXT_LENGTH):
    padded_text = text + "   "
    full_text = padded_text + text
    for i in range(len(padded_text)):
        yield full_text[i:i + length].ljust(length)

# Function to handle media control commands
def handle_media_control(action):
    try:
        subprocess.run([PLAYERCTL_PATH, action], check=True)
    except subprocess.CalledProcessError:
        pass

# Signal handlers
def signal_handler(signum, frame):
    if signum == signal.SIGUSR1:
        handle_media_control('previous')
    elif signum == signal.SIGUSR2:
        handle_media_control('next')

signal.signal(signal.SIGUSR1, signal_handler)
signal.signal(signal.SIGUSR2, signal_handler)

if __name__ == "__main__":
    scroll_generator = None
    current_text = ""
    
    while True:
        output = {}
        
        try:
            status = get_player_status()
            song = get_current_song()

            glyph = GLYPHS.get(status, DEFAULT_GLYPH)

            if song:
                display_text = song
            else:
                display_text = TEXT_WHEN_STOPPED

            if current_text != display_text or scroll_generator is None:
                current_text = display_text
                scroll_generator = scroll_text(display_text)
            
            try:
                song_text = next(scroll_generator)
            except StopIteration:
                scroll_generator = scroll_text(display_text)
                song_text = next(scroll_generator)

            output['text'] = f"<span font_family='{GLYPH_FONT_FAMILY}'>{glyph}</span> {song_text}"

        except Exception as e:
            output['text'] = f"⏹ Error: {str(e)}".ljust(SCROLL_TEXT_LENGTH + 2)

        print(json.dumps(output), flush=True)
        time.sleep(REFRESH_INTERVAL)

