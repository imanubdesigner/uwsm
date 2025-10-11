#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for theming + services setup"
print_info "\nStarting theming and service setup..."

# -------------------- Theming --------------------
run_command "pacman -S --noconfirm nwg-look qt5ct qt6ct kvantum kvantum-qt5" "Install Qt5/Qt6 and Kvantum theme engines" "yes"
run_command "mkdir -p /home/$SUDO_USER/.themes && unzip -o $BASE_DIR/assets/themes/Catppuccin-Dark-BL-MB.zip -d /home/$SUDO_USER/.themes && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.themes" "Install Catppuccin Dark BL MB GTK theme" "yes" "no"
run_command "unzip -o $BASE_DIR/assets/hyprcursor/catppuccin-mocha-light-cursors.zip -d /home/$SUDO_USER/.icons && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.icons" "Install Catppuccin Hyprcursor" "yes" "no"

# -------------------- Papirus Icons theme + Catppuccin --------------------
run_command "wget -qO- https://git.io/papirus-icon-theme-install | sh" "Papirus Icons Theme" "yes" "no"

run_command "sudo -u $SUDO_USER git clone https://github.com/catppuccin/papirus-folders.git /home/$SUDO_USER/papirus-folders" \
  "Clone Papirus-folders" \
  "yes" "no"

run_command "cp -r /home/$SUDO_USER/papirus-folders/src/* /usr/share/icons/Papirus" \
  "Catppuccin Mocha Papirus" \
  "yes"

run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/papirus-folders" \
  "Chown" \
  "yes" "no"

PAPIRUS_COMMANDS="cd papirus-folders && \
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && \
chmod +x ./papirus-folders && \
./papirus-folders -C cat-mocha-blue --theme Papirus-Dark && \
cd .. && \
rm -rf papirus-folders"

run_command "sudo -u $SUDO_USER sh -c 'cd /home/$SUDO_USER && $PAPIRUS_COMMANDS'" \
  "Catppuccin Mocha Blue" \
  "yes" "no"

# -------------------- Catppuccin Kvantum Theme--------------------
run_command "mkdir -p /home/$SUDO_USER/Documents/Cat" "Create Cat directory" "yes" "no"
run_command "cp -r $BASE_DIR/assets/themes/catppuccin-mocha-blue /home/$SUDO_USER/Documents/Cat" "Copy Cat folder for Kvantum" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Documents/Cat" "Set corrent ownership" "yes"

# -------------------- Fonts --------------------
run_command "fc-cache -fv" "Refresh font cache" "yes" "no"

# -------------------- Rebuild bat cache for catppuccin mocha theme --------------------
run_command "bat cache --build" "Rebuild bat syntax highlighting cache" "yes" "no"

# -------------------- Firewall setup --------------------
run_command "ufw default deny incoming" "Set UFW default policy: deny incoming" "yes"
run_command "ufw default allow outgoing" "Set UFW default policy: allow outgoing" "yes"
run_command "ufw enable" "Enable UFW firewall" "yes"
run_command "systemctl enable ufw" "Enable UFW to start on boot" "yes"

# -------------------- Set default shell --------------------
run_command "chsh -s /usr/bin/zsh $SUDO_USER" "Set default shell to zsh for user $SUDO_USER" "yes" "no"
run_command "sudo -u $SUDO_USER RUNZSH=no CHSH=no sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"" "Install Oh My Zsh for user $SUDO_USER" "yes" "no"

# -------------------- Neovim setup --------------------
run_command "git clone https://github.com/LazyVim/starter /home/$SUDO_USER/.config/nvim" "Clone LazyVim starter" "yes" "no"
run_command "rm -rf /home/$SUDO_USER/.config/nvim/.git" "Remove Git folder from LazyVim config" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/nvim" "Set correct ownership for Neovim config" "yes" "no"

# -------------------- Pacman Configuration --------------------
run_command "sudo cp $BASE_DIR/assets/pacman.conf /etc/pacman.conf" "Copy pacman.conf to /etc for manu user" "yes" "no"

# -------------------- Override Autologin --------------------
run_command "sudo mkdir -p /etc/systemd/system/getty@tty1.service.d" "Create TT1 directory" "yes" "no"
run_command "sudo cp $BASE_DIR/assets/override.conf /etc/systemd/system/getty@tty1.service.d" "Copy override.conf" "yes" "no"

# -------------------- .zprofile for uwsm autologin --------------------
run_command "cp $BASE_DIR/assets/.zprofile /home/$SUDO_USER/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.zprofile" "Copy zprofile configuration" "yes" "no"

# -------------------- Starship Configuration --------------------
run_command "cp $BASE_DIR/assets/starship.toml /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/starship.toml" "Copy Starship configuration" "yes" "no"

# -------------------- Chromium Flags --------------------
run_command "cp $BASE_DIR/assets/chromium-flags.conf /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/chromium-flags.conf" "Copy Chromium flags configuration" "yes" "no"

# -------------------- Wallpapers --------------------
run_command "mkdir -p /home/$SUDO_USER/Pictures/wallpapers" "Create wallpapers directory" "yes" "no"
run_command "cp $BASE_DIR/assets/wallpapers/wallhaven-3qzvr6.png /home/$SUDO_USER/Pictures/wallpapers" "Copy the wallpaper to wallpapers directory" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Pictures/wallpapers" "Set correct ownership for wallpapers directory" "yes" "no"

# -------------------- Swww current Wallpaper --------------------
run_command "mkdir -p /home/$SUDO_USER/.cache" "Create a .cache" "yes" "no"
run_command "cp -r $BASE_DIR/assets/swww /home/$SUDO_USER/.cache/" "Copy swww cache folder for wallpaper" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.cache/swww" "Set correct ownership on swww folder" "yes" "no"

# -------------------- Reflector Configuration --------------------
run_command "sudo mkdir -p /etc/xdg/reflector && sudo cp $BASE_DIR/assets/reflector/reflector.conf /etc/xdg/reflector/reflector.conf && sudo mkdir -p /etc/systemd/system/reflector.timer.d && sudo cp $BASE_DIR/assets/reflector/override.conf /etc/systemd/system/reflector.timer.d/override.conf && sudo systemctl daemon-reload && sudo systemctl enable reflector.timer" "Setup and enable reflector timer" "yes" "no"

# -------------------- Mkinitcpio & Nvidia Configuration (BEFORE driver installation) --------------------
print_bold_blue "\n=== Preparing NVIDIA Kernel Configuration ==="

# Step 1: Copy nvidia.conf (modprobe options)
run_command "sudo mkdir -p /etc/modprobe.d && sudo cp $BASE_DIR/assets/nvidia.conf /etc/modprobe.d/nvidia.conf" "Enable NVIDIA Modeset (KMS) for Wayland" "yes" "no"

# Step 2: Backup and modify mkinitcpio.conf BEFORE installing drivers
run_command "sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.backup" "Backup mkinitcpio.conf" "yes" "no"

run_command "sudo sed -i 's/^MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm btrfs)/' /etc/mkinitcpio.conf" "Add NVIDIA modules to mkinitcpio.conf" "yes" "no"

print_success "Kernel configuration prepared. NVIDIA drivers will trigger initramfs rebuild automatically."

# -------------------- NVIDIA Drivers Installation --------------------
print_bold_blue "\n=== Installing NVIDIA Drivers ==="
print_info "The installation will automatically compile DKMS modules and rebuild initramfs..."

run_command "pacman -S --noconfirm linux-headers nvidia-open-dkms nvidia-utils libva libva-utils lib32-nvidia-utils libva-nvidia-driver egl-wayland mesa lib32-mesa" "Install Nvidia Open DKMS (will auto-run mkinitcpio)" "yes"

run_command "pacman -S --noconfirm lact && systemctl enable --now lactd" "Install LACT for GPU" "yes"

print_success "NVIDIA drivers installed and initramfs rebuilt automatically!"

# -------------------- Post-install instructions --------------------
print_info "\nPost-installation instructions:"
print_bold_blue "Set themes and icons:"
echo "   - Run 'nwg-look' and set the global GTK and icon theme"
echo "   - Open 'kvantummanager' (run with sudo for system-wide changes) to select and apply the Catppuccin theme"
echo "   - Open 'qt6ct' and 'qt5ct' to set Kvantum style"
echo "------------------------------------------------------------------------"
