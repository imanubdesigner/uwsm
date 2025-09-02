#!/bin/bash
# Ferma il servizio Waybar
systemctl --user stop waybar.service

# Aspetta un attimo
sleep 1

# Riavvia il servizio
systemctl --user start waybar.service
