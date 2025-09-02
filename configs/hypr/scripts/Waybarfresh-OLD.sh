#!/bin/bash

# Termina tutti i processi waybar in esecuzione
killall waybar

# Aspetta un attimo per essere sicuri che il processo sia stato terminato
sleep 1

# Avvia waybar di nuovo
waybar &
