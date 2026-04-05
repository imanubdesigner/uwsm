#!/bin/bash

# Define base directory
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper functions
source $BASE_DIR/scripts/installer/helper.sh

# Set trap for unexpected exits
trap 'trap_message' INT TERM

log_message "Installation session started"
print_bold_blue "\nHyprland-UWSM Installer"
echo "--------------------------"

# Initial checks
check_root
check_os

# --- TEMPORARY SUDOERS CONFIGURATION ---
# Create a temporary sudoers file to allow NOPASSWD for the current session.
# This prevents repeated password prompts during the automated install.
echo "$SUDO_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/hyprland-installer-temp
chmod 0440 /etc/sudoers.d/hyprland-installer-temp
log_message "Temporary NOPASSWD access granted to $SUDO_USER"

# Run installation modules
run_script "prerequisites.sh" "Prerequisites Setup"
run_script "hypr.sh" "Hyprland Core & Addons"
run_script "utilities.sh" "Utilities & Configurations"
run_script "theming.sh" "Theming, Drivers & Services"
run_script "final.sh" "Finalization"

print_bold_blue "\n🌟 Installation Process Finished\n"
