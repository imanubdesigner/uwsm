#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# -------------------- Utilities --------------------
run_command "yay -S --sudoloop --noconfirm --needed python-terminaltexteffects xdg-terminal-exec humanity-icon-theme yaru-icon-theme hicolor-icon-theme localsend-bin gpu-screen-recorder walker-bin elephant-bin elephant-desktopapplications-bin elephant-files-bin elephant-websearch-bin elephant-clipboard-bin elephant-calc-bin elephant-runner-bin elephant-symbols-bin elephant-unicode-bin elephant-providerlist-bin elephant-menus-bin elephant-todo-bin waypaper gowall limine-mkinitcpio-hook limine-snapper-sync" "Install Utilities" "yes" "no"

# -------------------- Applications & mimeinfo --------------------
run_command "\
mkdir -p /home/$SUDO_USER/.local/share/applications && \
cp -r $BASE_DIR/assets/applications/* /home/$SUDO_USER/.local/share/applications/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/applications" \
  "Copy all .desktop and mime files from assets/applications to local share" "yes" "no"

# -------------------- Logo --------------------
run_command "cp $BASE_DIR/assets/logo.txt /home/$SUDO_USER/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/logo.txt" "Copy logo.txt" "yes" "no"

# -------------------- .XCompose --------------------
run_command "cp $BASE_DIR/assets/.XCompose /home/$SUDO_USER/ && chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.XCompose" "Copy .XCompose configuration to home directory" "yes" "no"

# -------------------- Mimeapps --------------------
run_command "cp $BASE_DIR/assets/mimeapps.list /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/mimeapps.list" "Copy mimeapps.list configuration" "yes" "no"

# -------------------- xdg-terminals.list --------------------
run_command "cp $BASE_DIR/assets/xdg-terminals.list /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/xdg-terminals.list" "Copy xdg-terminals.list configuration" "yes" "no"

# -------------------- Manu Folder (.local/share) --------------------
run_command "\
mkdir -p /home/$SUDO_USER/.local/share/manu && \
cp -r $BASE_DIR/assets/manu/* /home/$SUDO_USER/.local/share/manu/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/manu" \
    "Copy manu folder content to .local/share" "yes" "no"

echo "------------------------------------------------------------------------"
