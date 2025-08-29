#!/bin/bash
# Wrapper per xdg-open che garantisce la trasparenza in Thunar

# Verifica se l'argomento è una directory
if [ -d "$1" ]; then
  # Imposta le variabili d'ambiente per Wayland e GTK
  export GDK_BACKEND=wayland
  export GTK_THEME=Catppuccin-Dark

  # Avvia Thunar in una nuova finestra con trasparenza
  thunar --new-window "$1" &
else
  # Per altri tipi di file, utilizza l'xdg-open originale
  /usr/bin/xdg-open "$@" &
fi
