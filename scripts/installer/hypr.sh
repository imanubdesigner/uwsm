#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for hypr section"
print_info "\nStarting hypr setup..."
print_info "\nEverything is recommended to INSTALL"

# -------------------- Hyprland Installation --------------------
run_command "pacman -S --noconfirm hyprland hyprpicker hypridle hyprlock uwsm xdg-desktop-portal-hyprland qt5-wayland qt6-wayland hyprsunset hyprpolkitagent dunst" "Install complete Hyprland ecosystem (core, session manager, wayland support, addons)" "yes"

# -------------------- Configuration Files --------------------
run_command "\
cp -r $BASE_DIR/configs/hypr /home/$SUDO_USER/.config/ && \
cp -r $BASE_DIR/configs/uwsm /home/$SUDO_USER/.config/ && \
cp -r $BASE_DIR/configs/systemd /home/$SUDO_USER/.config/ && \
cp -r $BASE_DIR/configs/dunst /home/$SUDO_USER/.config/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/hypr && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/uwsm && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/systemd && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/dunst" \
  "Copy all Hyprland configuration files" "yes" "no"

echo "------------------------------------------------------------------------"
