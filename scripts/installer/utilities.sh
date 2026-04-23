#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# -------------------- Utilities --------------------
run_command "yay -S --sudoloop --noconfirm --needed helium-browser-bin hyprland-preview-share-picker-git python-terminaltexteffects xdg-terminal-exec localsend-bin walker elephant elephant-desktopapplications elephant-files elephant-websearch elephant-clipboard elephant-calc elephant-runner elephant-symbols elephant-unicode elephant-providerlist elephant-menus elephant-todo yaru-icon-theme gowall limine-mkinitcpio-hook limine-snapper-sync" "Install Utilities" "no" "no"

# -------------------- Applications & mimeinfo --------------------
run_command "\
mkdir -p /home/$SUDO_USER/.local/share/applications && \
cp -r $BASE_DIR/assets/applications/* /home/$SUDO_USER/.local/share/applications/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/applications" \
  "Copy all .desktop and mime files from assets/applications to local share" "yes" "no"

# -------------------- Logo --------------------
run_command "cp $BASE_DIR/assets/logo.txt /home/$SUDO_USER/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/logo.txt" "Copy logo.txt" "no" "no"

# -------------------- .XCompose --------------------
run_command "cp $BASE_DIR/assets/.XCompose /home/$SUDO_USER/ && chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.XCompose" "Copy .XCompose configuration to home directory" "no" "no"

# -------------------- Manu Folder (.local/share) --------------------
run_command "\
mkdir -p /home/$SUDO_USER/.local/share/manu && \
cp -r $BASE_DIR/assets/manu/* /home/$SUDO_USER/.local/share/manu/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/manu" \
    "Copy manu folder content to .local/share" "yes" "no"

echo "------------------------------------------------------------------------"
