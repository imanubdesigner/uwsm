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
    except Exception as e:
        return "stopped"

# Function to get currently playing song using playerctl
def get_current_song():
    try:
        result = subprocess.run([PLAYERCTL_PATH, 'metadata', 'title'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        song_title = result.stdout.decode('utf-8').strip()
        if result.returncode != 0 or not song_title:
            return None  # Return None if no song is playing or an error occurred
        return song_title
    except Exception as e:
        return None

# Function to generate scrolling text with fixed length
def scroll_text(text, length=SCROLL_TEXT_LENGTH):
    # Add some padding spaces for smoother scrolling
    padded_text = text + "   "
    full_text = padded_text + text  # Repeat the text for continuous scrolling
    
    for i in range(len(padded_text)):
        yield full_text[i:i + length].ljust(length)

# Function to handle media control commands
def handle_media_control(action):
    try:
        subprocess.run([PLAYERCTL_PATH, action], check=True)
    except subprocess.CalledProcessError:
        pass  # Ignore errors if no player is available

# Signal handlers for media control (optional - for external control)
def signal_handler(signum, frame):
    if signum == signal.SIGUSR1:  # Previous track
        handle_media_control('previous')
    elif signum == signal.SIGUSR2:  # Next track
        handle_media_control('next')

# Register signal handlers
signal.signal(signal.SIGUSR1, signal_handler)
signal.signal(signal.SIGUSR2, signal_handler)

if __name__ == "__main__":
    scroll_generator = None
    current_text = ""
    
    while True:
        output = {}
        
        try:
            # Get the player status and song title
            status = get_player_status()
            song = get_current_song()

            # Get the glyph based on player status
            glyph = GLYPHS.get(status, DEFAULT_GLYPH)

            # Determine what text to display
            if song:
                display_text = song
            else:
                display_text = TEXT_WHEN_STOPPED

            # Always scroll the text (whether it's a song or the "boring" message)
            if current_text != display_text or scroll_generator is None:
                current_text = display_text
                scroll_generator = scroll_text(display_text)
            
            try:
                song_text = next(scroll_generator)
            except StopIteration:
                scroll_generator = scroll_text(display_text)
                song_text = next(scroll_generator)

            # Since Waybar can't distinguish click areas within text, 
            # we'll use different mouse actions for different controls
            
            # Just show the music info without control buttons in the text
            # The controls will be handled via different mouse interactions
            output['text'] = f"<span font_family='{GLYPH_FONT_FAMILY}'>{glyph}</span> {song_text}"
            
            # Remove all click events from the script - let Waybar handle them
            # The script only provides the display text
            
            # Alternative: if you want separate clickable areas, you can use:
            # output['on-click'] = "toggle_play_pause"  # Main area toggles play/pause
            # You would need to handle these in your bar configuration

        except Exception as e:
            output['text'] = f"⏹ Error: {str(e)}".ljust(SCROLL_TEXT_LENGTH + 2)  # Show error with stop symbol

        # Print the JSON output for Waybar
        print(json.dumps(output), flush=True)

        time.sleep(REFRESH_INTERVAL)
