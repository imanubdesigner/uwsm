#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# # -------------------- Utilities --------------------
# run_command "yay -S --sudoloop --noconfirm waypaper gowall qview limine-mkinitcpio-hook limine-snapper-sync" "Install Utilities" "yes" "no"

# -------------------- Utilities --------------------
run_command "yay -S --sudoloop --noconfirm elephant elephant-bluetooth elephant-calc elephant-clipboard elephant-desktopapplications elephant-files elephant-menus elephant-providerlist elephant-runner elephant-symbols elephant-todo elephant-unicode elephant-websearch waypaper gowall qview limine-mkinitcpio-hook limine-snapper-sync" "Install Utilities" "yes" "no"

run_command "\
mkdir -p /home/$SUDO_USER/.local/share/applications && \
cp $BASE_DIR/assets/nvim.desktop /home/$SUDO_USER/.local/share/applications/ && \
cp $BASE_DIR/assets/mimeinfo.cache /home/$SUDO_USER/.local/share/applications/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/applications" \
  "Create applications folder and copy Neovim desktop files from assets" "yes" "no"

run_command "cp $BASE_DIR/assets/mimeapps.list /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/mimeapps.list" "Copy mimeapps.list configuration" "yes" "no"
run_command "cp -r $BASE_DIR/assets/bin /home/$SUDO_USER/.local/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/bin" "Copy bin folder" "yes" "no"
# run_command "cp -r $BASE_DIR/configs/waybar /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/waybar" "Copy Waybar config" "yes" "no"
# run_command "cp -r $BASE_DIR/configs/waypaper /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/waypaper" "Copy Waypaper config" "yes" "no"

echo "------------------------------------------------------------------------"
