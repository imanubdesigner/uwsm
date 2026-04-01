#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for theming + services setup"
print_info "\nStarting theming and service setup..."

# -------------------- Fonts --------------------
run_command "fc-cache -fv" "Refresh font cache" "no" "no"

# -------------------- Rebuild bat cache for catppuccin mocha theme --------------------
run_command "bat cache --build" "Rebuild bat syntax highlighting cache" "no" "no"

# # -------------------- Firewall setup --------------------
# run_command "ufw default deny incoming" "Set UFW default policy: deny incoming" "no"
# run_command "ufw default allow outgoing" "Set UFW default policy: allow outgoing" "no"
# run_command "ufw allow 53317/udp" "Set udp" "no"
# run_command "ufw allow 53317/tcp" "Set tcp" "no"
# run_command "ufw enable" "Enable UFW firewall" "no"
# run_command "systemctl enable ufw" "Enable UFW to start on boot" "no"

# -------------------- TLP Power Management --------------------
run_command "systemctl disable --now power-profiles-daemon 2>/dev/null || true" "Disable power-profiles-daemon (if present)" "no"
run_command "systemctl mask power-profiles-daemon" "Mask power-profiles-daemon" "no"
run_command "systemctl enable tlp" "Enable TLP power management" "no"
run_command "sudo cp $BASE_DIR/assets/tlp.conf /etc/tlp.conf" "Copy TLP configuration" "no" "no"

# -------------------- Set default shell --------------------
run_command "chsh -s /usr/bin/zsh $SUDO_USER" "Set default shell to zsh for user $SUDO_USER" "no" "no"
run_command "sudo -u $SUDO_USER RUNZSH=no CHSH=no sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"" "Install Oh My Zsh for user $SUDO_USER" "no" "no"

# -------------------- Pacman Configuration --------------------
run_command "sudo cp $BASE_DIR/assets/pacman.conf /etc/pacman.conf" "Copy pacman.conf to /etc for manu user" "no" "no"

# -------------------- Override Autologin --------------------
run_command "sudo mkdir -p /etc/systemd/system/getty@tty1.service.d" "Create TT1 directory" "no" "no"
run_command "sudo cp $BASE_DIR/assets/override.conf /etc/systemd/system/getty@tty1.service.d" "Copy override.conf" "no" "no"

# -------------------- .zprofile for uwsm autologin --------------------
run_command "cp $BASE_DIR/assets/.zprofile /home/$SUDO_USER/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.zprofile" "Copy zprofile configuration" "no" "no"

# -------------------- Starship Configuration --------------------
run_command "cp $BASE_DIR/assets/starship.toml /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/starship.toml" "Copy Starship configuration" "no" "no"

# -------------------- Wallpapers --------------------
run_command "mkdir -p /home/$SUDO_USER/Pictures/wallpapers" "Create wallpapers directory" "no" "no"
run_command "cp $BASE_DIR/assets/wallpapers/wallhaven-3qzvr6.png /home/$SUDO_USER/Pictures/wallpapers" "Copy the wallpaper to wallpapers directory" "no" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Pictures/wallpapers" "Set correct ownership for wallpapers directory" "no" "no"

# -------------------- Swww current Wallpaper --------------------
run_command "mkdir -p /home/$SUDO_USER/.cache" "Create a .cache" "no" "no"
run_command "cp -r $BASE_DIR/assets/awww /home/$SUDO_USER/.cache/" "Copy awww cache folder for wallpaper" "no" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.cache/awww" "Set correct ownership on swww folder" "no" "no"

# -------------------- Fstab Configuration for SSD Auto Mount --------------------
FSTAB_ENTRY="# SSD Auto Mount\nUUID=0C1A3D631A3D4ACA /mnt/Dati ntfs3 defaults,noatime,nofail,windows_names,prealloc,uid=1000,gid=1000 0 0"

run_command "echo -e \"$FSTAB_ENTRY\" | sudo tee -a /etc/fstab" \
  "Add SSD auto-mount entry to /etc/fstab" \
  "yes"

# -------------------- Reflector Configuration --------------------
run_command "sudo mkdir -p /etc/xdg/reflector && sudo cp $BASE_DIR/assets/reflector/reflector.conf /etc/xdg/reflector/reflector.conf && sudo mkdir -p /etc/systemd/system/reflector.timer.d && sudo cp $BASE_DIR/assets/reflector/override.conf /etc/systemd/system/reflector.timer.d/override.conf && sudo systemctl daemon-reload && sudo systemctl enable reflector.timer" "Setup and enable reflector timer" "no" "no"

# -------------------- Snapper + Snap-pac Configuration --------------------
print_bold_blue "\n=== Configuring Snapper + Snap-pac ==="

# Step 1: Copy Snapper root configuration
run_command "sudo mkdir -p /etc/snapper/configs && sudo cp $BASE_DIR/assets/snap/root /etc/snapper/configs/root" \
  "Copy Snapper root configuration" \
  "yes" "no"

# Step 2: Copy snap-pac.ini
run_command "sudo cp $BASE_DIR/assets/snap/snap-pac.ini /etc/snap-pac.ini" \
  "Copy snap-pac.ini configuration" \
  "yes" "no"

# Step 3: Enable Snapper automatic cleanup timer
run_command "sudo systemctl enable --now snapper-cleanup.timer" \
  "Enable Snapper automatic cleanup timer" \
  "yes"

# -------------------- Mkinitcpio & Nvidia Configuration (BEFORE driver installation) --------------------
print_bold_blue "\n=== Preparing NVIDIA Kernel Configuration ==="

# Step 1: Copy nvidia.conf (modprobe options)
run_command "sudo mkdir -p /etc/modprobe.d && sudo cp $BASE_DIR/assets/nvidia.conf /etc/modprobe.d/nvidia.conf" "Enable NVIDIA Modeset (KMS) for Wayland" "no" "no"

# Step 2: Backup and modify mkinitcpio.conf BEFORE installing drivers
run_command "sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.backup" "Backup mkinitcpio.conf" "no" "no"

run_command "sudo sed -i 's/^MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm btrfs)/' /etc/mkinitcpio.conf" "Add NVIDIA modules to mkinitcpio.conf" "no" "no"

run_command "sudo sed -i -E '/^HOOKS=\(/ { s/(^|[[:space:]])btrfs-overlayfs($|[[:space:]])/ /g; s/[[:space:]]+/ /g; s/[[:space:]]*\)/)/; s/\)$/ btrfs-overlayfs)/ }' /etc/mkinitcpio.conf" "Put btrfs-overlayfs once at end of HOOKS" "no" "no"

print_success "Kernel configuration prepared. NVIDIA drivers will trigger initramfs rebuild automatically."

# -------------------- Limine Wipe limine.conf hook --------------------
run_command "install -D -m 0644 -o root -g root \"$BASE_DIR/assets/99-limine-wipe-efi-conf.hook\" \"/etc/pacman.d/hooks/99-limine-wipe-efi-conf.hook\"" "Install Limine wipe-efi-conf pacman hook" "no"

# -------------------- NVIDIA Drivers Installation --------------------
print_bold_blue "\n=== Installing NVIDIA Drivers ==="
print_info "The installation will automatically compile DKMS modules and rebuild initramfs..."

run_command "pacman -S --noconfirm --needed linux-headers nvidia-open-dkms nvidia-utils libva libva-utils lib32-nvidia-utils libva-nvidia-driver egl-wayland mesa lib32-mesa" "Install Nvidia Open DKMS (will auto-run mkinitcpio)" "no"

run_command "pacman -S --noconfirm --needed lact && systemctl enable --now lactd" "Install LACT for GPU" "no"

print_success "NVIDIA drivers installed and initramfs rebuilt automatically!"

# -------------------- Limine Customization (Hypruccin Theme) --------------------
print_bold_blue "\n=== Customizing Limine Bootloader ==="

# 1. Remove the redundant /boot/limine directory to avoid configuration conflicts
# Using "yes" "yes" because this requires sudo and we want confirmation
run_command "rm -rf /boot/limine" "Remove redundant /boot/limine directory" "no" "yes"

if command -v limine &>/dev/null; then
  # 1. Detect current CMDLINE
  LIMINE_CONF_PATH="/boot/limine.conf"

  if [[ -f "$LIMINE_CONF_PATH" ]]; then
    CURRENT_CMDLINE=$(grep "^[[:space:]]*cmdline:" "$LIMINE_CONF_PATH" | head -1 | sed 's/^[[:space:]]*cmdline:[[:space:]]*//')
    log_message "Detected current CMDLINE: $CURRENT_CMDLINE"
  else
    CURRENT_CMDLINE="root=UUID=$(findmnt -no UUID /) rw rootflags=subvol=@"
    print_warning "Limine config not found, using generic fallback."
  fi

  # 2. Copy config files (Using "yes" for sudo because these are system files)
  run_command "mkdir -p /etc/default && cp $BASE_DIR/assets/limine/default.conf /etc/default/limine" \
    "Copy custom Limine default config" "yes" "yes"

  # 3. Inject CMDLINE (Using "no" for confirmation, "yes" for sudo)
  run_command "sed -i \"s|@@CMDLINE@@|$CURRENT_CMDLINE|g\" /etc/default/limine" \
    "Inject detected CMDLINE" "no" "yes"

  # 4. Replace limine.conf
  run_command "cp $BASE_DIR/assets/limine/limine.conf /boot/limine.conf" \
    "Copy custom limine.conf to /boot" "yes" "yes"

  # 5. Enable service and Update
  run_command "systemctl enable limine-snapper-sync.service" \
    "Enable Limine-Snapper-Sync service" "yes" "yes"

  run_command "limine-update && limine-snapper-sync" \
    "Generate Limine boot entries" "yes" "yes"

else
  print_warning "Limine not found. Skipping bootloader customization."
fi

print_success "Limine configuration updated successfully!"
# -------------------- Post-install instructions --------------------
print_info "\nPost-installation instructions:"
print_bold_blue "Set themes and icons:"
echo "   - Run 'nwg-look' and set the global GTK and icon theme"
echo "   - Open 'kvantummanager' (run with sudo for system-wide changes) to select and apply the Catppuccin theme"
echo "   - Open 'qt6ct' and 'qt5ct' to set Kvantum style"
echo "------------------------------------------------------------------------"
