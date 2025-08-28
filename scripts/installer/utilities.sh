#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# -------------------- Bar & Launcher --------------------
run_command "pacman -S --noconfirm waybar" "Install Waybar - Status Bar" "yes"
run_command "cp -r $BASE_DIR/configs/waybar /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/waybar" "Copy Waybar config" "yes" "no"

run_command "yay -S --sudoloop --noconfirm tofi" "Install Tofi - Application Launcher" "yes" "no"
run_command "cp -r $BASE_DIR/configs/tofi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/tofi" "Copy Tofi config(s)" "yes" "no"

# -------------------- Neovim open for Thunar --------------------
run_command "cp -r $BASE_DIR/configs/applications /home/$SUDO_USER/.local/share/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.local/share/applications" "Copy applications folder to local share" "yes" "no"

# -------------------- Clipboard --------------------
run_command "pacman -S --noconfirm cliphist" "Install Cliphist - Clipboard Manager" "yes"

# -------------------- Wallpapers --------------------
run_command "yay -S --sudoloop --noconfirm swww" "Install SWWW for wallpaper management" "yes" "no"
run_command "mkdir -p /home/$SUDO_USER/Pictures/wallpapers && cp $BASE_DIR/assets/wallpapers/wallhaven-9dkywx_3840x2160.png /home/$SUDO_USER/Pictures/wallpapers/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Pictures/wallpapers" "Create wallpapers folder and copy default wallpaper" "yes" "no"
run_command "yay -S --sudoloop --noconfirm waypaper" "Install Waypaper - Wallpaper tool" "yes" "no"
run_command "cp -r $BASE_DIR/configs/waypaper /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/waypaper" "Copy Waypaper config" "yes" "no"

# -------------------- Screenshot --------------------
run_command "yay -S --sudoloop --noconfirm grimblast" "Install Grimblast - Screenshot tool" "yes" "no"

# -------------------- Other utilities --------------------
run_command "yay -S --sudoloop --noconfirm qview" "Install qView - Image Viewer" "yes" "no"

echo "------------------------------------------------------------------------"
