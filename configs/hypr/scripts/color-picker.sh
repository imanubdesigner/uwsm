#!/bin/bash

sleep 0.1
COLOR=$(hyprpicker | grep -E '^#')

if [ -n "$COLOR" ]; then
  echo "$COLOR" | wl-copy
  notify-send " Color Copied!" "$COLOR" -h string:fgcolor:$COLOR
fi
