#!/bin/bash

# Definisce il tipo di screenshot dall'argomento (es. "screen", "active", "area")
SCREENSHOT_TYPE=$1

# Definisce la directory di salvataggio all'interno di Pictures
SAVE_DIR="$HOME/Pictures/Screenshot"

# Controlla se il tipo di screenshot è stato passato come argomento
if [ -z "$1" ]; then
  echo "Errore: specificare il tipo di screenshot (screen, active, area)."
  exit 1
fi

# Crea la directory se non esiste, usando l'opzione -p per evitare errori
mkdir -p "$SAVE_DIR"

# Genera un nome di file compatibile senza due punti (:)
FILENAME="screenshot-$(date '+%Y-%m-%d_%H-%M-%S').png"

# Esegue grimblast per salvare e copiare l'immagine
grimblast --notify copysave "$SCREENSHOT_TYPE" "$SAVE_DIR/$FILENAME"
