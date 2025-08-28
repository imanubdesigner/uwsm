#!/usr/bin/env bash

# Cartella con le icone
icodir="$HOME/.config/dunst/icons"

# Hyprsunset Process Check
if pgrep -x "hyprsunset" >/dev/null; then
  # If Hyprsunset is activated, Kill the process
  pkill -x "hyprsunset"
  dunstify -a "HyprSunset" -r 9999 -t 1000 -i "$icodir/brightness-7.svg" "HyprSunset" "Disattivato"
else
  # If NOT, take the rules on your hyprsunset.conf inside the Hype folder
  hyprsunset &
  dunstify -a "HyprSunset" -r 9999 -t 1000 -i "$icodir/brightness-3.svg" "HyprSunset" "Attivato"
fi
