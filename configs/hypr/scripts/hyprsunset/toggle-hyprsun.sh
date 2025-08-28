#!/bin/bash

ICON_DIR="$HOME/.config/dunst/icons"

if pgrep -x hyprsunset >/dev/null; then
  # Se è già in esecuzione → spegnilo
  pkill -x hyprsunset
  notify-send -i "$ICON_DIR/sun.svg" "Hyprsunset OFF"
else
  # Se non è in esecuzione → accendilo con temperatura 3500K
  hyprsunset -t 3500 &
  notify-send -i "$ICON_DIR/moon.svg" "Hyprsunset ON"
fi
