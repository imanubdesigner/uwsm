#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# -------------------- Utilities --------------------
run_command "yay -S --sudoloop --noconfirm --needed gpu-screen-recorder walker-bin elephant-bin elephant-bluetooth-bin elephant-calc-bin elephant-clipboard-bin elephant-desktopapplications-bin elephant-files-bin elephant-menus-bin elephant-providerlist-bin elephant-runner-bin elephant-symbols-bin elephant-todo-bin elephant-unicode-bin elephant-websearch-bin waypaper gowall qview limine-mkinitcpio-hook limine-snapper-sync" "Install Utilities" "yes" "no"

# -------------------- Applications & mimeinfo --------------------
run_command "\
mkdir -p /home/$SUDO_USER/.local/share/applications && \
cp -r $BASE_DIR/assets/applications/* /home/$SUDO_USER/.local/share/applications/ && \
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/applications" \
  "Copy all .desktop and mime files from assets/applications to local share" "yes" "no"

# -------------------- Logo --------------------
run_command "cp $BASE_DIR/assets/logo.txt /home/$SUDO_USER/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/logo.txt" "Copy logo.txt" "yes" "no"

# -------------------- Mimeapps --------------------
run_command "cp $BASE_DIR/assets/mimeapps.list /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/mimeapps.list" "Copy mimeapps.list configuration" "yes" "no"

# -------------------- Scripts Folder Bin --------------------
run_command "cp -r $BASE_DIR/assets/bin /home/$SUDO_USER/.local/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/bin" "Copy bin folder" "yes" "no"

echo "------------------------------------------------------------------------"
