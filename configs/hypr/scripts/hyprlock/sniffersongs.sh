#!/bin/bash

# Get the first available player
player=$(playerctl -l 2>/dev/null | head -n1)

if [[ -n "$player" ]]; then
  # Check if any player is currently playing
  if [[ $(playerctl status 2>/dev/null) == "Playing" ]]; then
    status='  '
  else
    status='  '
  fi

  # Get song info from the active player
  song_info=$(playerctl metadata --format "$status 󰎄   {{title}} - {{artist}}" 2>/dev/null)

  # If we got valid info, display it
  if [[ -n "$song_info" && "$song_info" != "$status       " ]]; then
    echo "$song_info"
  else
    echo ""
  fi
else
  echo ""
fi
