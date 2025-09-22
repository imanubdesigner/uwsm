#!/usr/bin/env python3

#    ┏┓┏┓┳┓┏┓┓ ┓ ┳┳┓┏┓  ┏┳┓┏┓┏┓┏┓┏┳┓  ┏┓┏┓┳┓┏┓    ┏┓
#    ┗┓┃ ┣┫┃┃┃ ┃ ┃┃┃┃┓   ┃ ┣  ┃┃  ┃   ┗┓┃┃┃┃┃┓  ┓┏┏┛
#    ┗┛┗┛┛┗┗┛┗┛┗┛┻┛┗┗┛   ┻ ┗┛┗┛┗┛ ┻   ┗┛┗┛┛┗┗┛  ┗┛┗━
#    with static text before the songs   |   by Manu

import subprocess
import time
import json
import signal

# Customization settings
GLYPH_FONT_FAMILY = "Symbols Nerd Font Mono"
GLYPHS = {
    "paused": "",
    "playing": "",
    "stopped": ""
}
DEFAULT_GLYPH = "▶"
TEXT_WHEN_STOPPED = "No music "
SCROLL_TEXT_LENGTH = 25
REFRESH_INTERVAL = 0.4
PLAYERCTL_PATH = "/usr/bin/playerctl"

def get_player_status():
    try:
        result = subprocess.run([PLAYERCTL_PATH, 'status'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        status = result.stdout.decode('utf-8').strip().lower()
        if result.returncode != 0 or not status:
            return "stopped"
        return status
    except Exception:
        return "stopped"

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

def scroll_text(text, length=SCROLL_TEXT_LENGTH):
    padded_text = text + "   "
    full_text = padded_text + text
    for i in range(len(padded_text)):
        yield full_text[i:i + length].ljust(length)

def handle_media_control(action):
    try:
        subprocess.run([PLAYERCTL_PATH, action], check=True)
    except subprocess.CalledProcessError:
        pass

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

            if status in ["playing", "paused"] and song:
                # Scroll the song title
                if current_text != song or scroll_generator is None:
                    current_text = song
                    scroll_generator = scroll_text(song)

                try:
                    song_text = next(scroll_generator)
                except StopIteration:
                    scroll_generator = scroll_text(song)
                    song_text = next(scroll_generator)

                glyph = GLYPHS.get(status, DEFAULT_GLYPH)
                output['text'] = f"<span font_family='{GLYPH_FONT_FAMILY}'>{glyph}</span> {song_text}"

            else:
                # Stopped or no song: show only "No music "
                output['text'] = TEXT_WHEN_STOPPED
                scroll_generator = None

        except Exception as e:
            output['text'] = f"⏹ Error: {str(e)}".ljust(SCROLL_TEXT_LENGTH + 2)

        print(json.dumps(output), flush=True)
        time.sleep(REFRESH_INTERVAL)

