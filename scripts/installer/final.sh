#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Final setup script started"
print_bold_blue "\nCongratulations! Mini Hypr setup is complete! Reboot is recommended"

print_bold_blue "\nRepository Information:"
echo "   - GitHub Repository: https://github.com/imanubdesigner/mini-hypr"
echo "   - This is an experiment. Seems to work well. Changes will be made to make it even better."

print_success "\nEnjoy your new Hyprland environment! Reboot now for the best experience <3"

echo "------------------------------------------------------------------------"
