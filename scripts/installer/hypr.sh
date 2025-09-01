#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for hypr section"
print_info "\nStarting hypr setup..."
print_info "\nEverything is recommended to INSTALL"

# -------------------- Hyprland core --------------------
run_command "pacman -S --noconfirm hyprland hyprpicker hypridle hyprlock" "Install Hyprland and core tools (Must)" "yes"
run_command "cp -r $BASE_DIR/configs/hypr /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/hypr" "Copy Hyprland config folder (Must)" "yes" "no"

# -------------------- UWSM --------------------
run_command "pacman -S --noconfirm uwsm" "Install the Universal Window Session Manager (Must)" "yes"
run_command "cp -r $BASE_DIR/configs/uwsm /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/uwsm" "Copy UWSM config folder (Must)" "yes" "no"

# -------------------- Systemd Folder --------------------
run_command "cp -r $BASE_DIR/configs/systemd /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/systemd" "Copy systemd config folder (Must)" "yes" "no"

# -------------------- Wayland support --------------------
run_command "pacman -S --noconfirm xdg-desktop-portal-hyprland" "Install XDG desktop portal for Hyprland" "yes"
run_command "pacman -S --noconfirm qt5-wayland qt6-wayland" "Install QT support on Wayland" "yes"

# -------------------- Hyprland addons --------------------
run_command "pacman -S --noconfirm hyprsunset" "Install blue-filter (Night Light)" "yes"
run_command "pacman -S --noconfirm hyprpolkitagent" "Install Hyprpolkitagent for authentication dialogs" "yes"

# -------------------- Notifications --------------------
run_command "pacman -S --noconfirm dunst" "Install Dunst notification daemon" "yes"
run_command "cp -r $BASE_DIR/configs/dunst /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/dunst" "Copy Dunst config" "yes" "no"

echo "------------------------------------------------------------------------"
