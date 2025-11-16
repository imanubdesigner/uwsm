#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for hypr section"
print_info "\nStarting hypr setup..."
print_info "\nEverything is recommended to INSTALL"

run_command "pacman -S --needed --noconfirm hyprland hyprland-guiutils satty jq grim slurp wl-clipboard libnotify waybar hyprpicker hypridle hyprlock uwsm libnewt xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt5-remoteobjects qt5-wayland qt6-wayland hyprsunset hyprpolkitagent mako" "Install complete Hyprland ecosystem (core, session manager, wayland support, addons)" "yes"

run_command "systemctl --user enable waybar.service" \
  "Enable Waybar packaged user unit (no start now)" "yes" "no"

echo "------------------------------------------------------------------------"
