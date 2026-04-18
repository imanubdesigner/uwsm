#!/bin/bash

# Define base directory
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper functions
source $BASE_DIR/scripts/installer/helper.sh

log_message "Finalization script started"
print_bold_blue "\nCongratulations! Hyprland-UWSM setup is complete!"

# --- SUDOERS CLEANUP ---
# Remove the temporary NOPASSWD file to restore system security.
if [ -f /etc/sudoers.d/hyprland-installer-temp ]; then
  rm /etc/sudoers.d/hyprland-installer-temp
  log_message "Temporary sudoers file removed successfully"
  print_success "Security: Temporary sudo privileges have been revoked."
fi

# --- Final Message ---
print_success "Hyprland-UWSM setup completed successfully! Please reboot your system."
echo "------------------------------------------------------------------------"
