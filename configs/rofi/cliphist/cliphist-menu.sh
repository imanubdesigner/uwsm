#!/usr/bin/env bash

# ┏┓┓ ┳┏┓┓┏┳┏┓┏┳┓
# ┃ ┃ ┃┃┃┣┫┃┗┓ ┃
# ┗┛┗┛┻┣┛┛┗┻┗┛ ┻
#         by Manu

# Directory and theme for Rofi
dir="$HOME/.config/rofi/cliphist/"
theme='cliphist'

# Show the clipboard history list using Rofi
selection=$(cliphist list | rofi \
  -dmenu \
  -p "Clipboard" \
  -theme "${dir}/${theme}.rasi" \
  -i \
  -no-custom \
  -eh 2)

# If a selection is made, decode and copy it to clipboard
if [[ -n "$selection" ]]; then
  echo "$selection" | cliphist decode | wl-copy
  # Notify the user that the selection was copied to clipboard
  notify-send -t 3000 "Rofi Clipboard" "Copied to clipboard." -i clipboard

else
  # Notify the user that no selection was made
  notify-send -t 3000 "Rofi Clipboard" "No selection made." -i clipboard
fi
