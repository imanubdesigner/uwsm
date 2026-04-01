#!/bin/bash

# -------------------------------------------------------
#  first_run_all.sh — runs once on first Hyprland login
#  Flag: ~/.config/hypr/.first-run-done
#  Location: ~/.local/share/manu/bin/first_run_all.sh
# -------------------------------------------------------

FLAG="$HOME/.config/hypr/.first-run-done"
BIN_DIR="$HOME/.local/share/manu/bin"
LOG="$HOME/.local/share/manu/first-run.log"

# Already ran — exit immediately
[[ -f "$FLAG" ]] && exit 0

mkdir -p "$(dirname "$LOG")"
echo "$(date): First run started" >> "$LOG"

# -------------------- Firewall --------------------
echo "$(date): Running firewall.sh..." >> "$LOG"
bash "$BIN_DIR/firewall.sh" >> "$LOG" 2>&1

# -------------------- Elephant --------------------
echo "$(date): Running elephant.sh..." >> "$LOG"
bash "$BIN_DIR/elephant.sh" >> "$LOG" 2>&1

# -------------------- GNOME / GTK Theme --------------------
echo "$(date): Running gnome-theme.sh..." >> "$LOG"
bash "$BIN_DIR/gnome-theme.sh" >> "$LOG" 2>&1

# -------------------- XDG user dirs --------------------
echo "$(date): Updating XDG user dirs..." >> "$LOG"
xdg-user-dirs-update >> "$LOG" 2>&1

# -------------------------------------------------------
# Mark as done — won't run again
touch "$FLAG"
echo "$(date): First run completed successfully." >> "$LOG"

# Optional: send a desktop notification via mako
notify-send "Setup" "First-run configuration completed ✓" 2>/dev/null || true
