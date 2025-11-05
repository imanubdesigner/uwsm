#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source "$BASE_DIR/scripts/installer/helper.sh"

log_message "Installation started for theming + services setup"
print_info "\nStarting theming and service setup..."

# -------------------- Theming --------------------
run_command "pacman -S --noconfirm --needed nwg-look qt5ct qt6ct kvantum kvantum-qt5" "Install Qt5/Qt6 and Kvantum theme engines" "yes"

# -------------------- Catppuccin GTK (Fausto) - Dark Blue --------------------
run_command "mkdir -p /home/$SUDO_USER/.themes /home/$SUDO_USER/.config/gtk-4.0 && TAR=\$BASE_DIR/assets/themes/Catppuccin-BL-LB-dark.tar.xz && [ -f \"\$TAR\" ] || { echo \"Theme not found: \$TAR\"; exit 1; }; tar -xJvf \"\$TAR\" -C /home/$SUDO_USER/.themes && THEME_DIR=/home/$SUDO_USER/.themes/Catppuccin-BL-LB-Dark && if [ ! -d \"\$THEME_DIR\" ]; then THEME_DIR=\$(ls -d /home/$SUDO_USER/.themes/Catppuccin-BL-LB-Dark* 2>/dev/null | grep -vE 'hdpi' | head -n1); fi && rm -rf /home/$SUDO_USER/.config/gtk-4.0/assets 2>/dev/null || true && ln -snf \"\$THEME_DIR/gtk-4.0/assets\" /home/$SUDO_USER/.config/gtk-4.0/assets && ln -snf \"\$THEME_DIR/gtk-4.0/gtk.css\" /home/$SUDO_USER/.config/gtk-4.0/gtk.css && ln -snf \"\$THEME_DIR/gtk-4.0/gtk-dark.css\" /home/$SUDO_USER/.config/gtk-4.0/gtk-dark.css" "Install Catppuccin GTK (tar.xz → ~/.themes + symlink GTK4)" "yes" "no"

# -------------------- Catppuccin Hyprcursor --------------------
run_command "unzip -o \"$BASE_DIR/assets/hyprcursor/catppuccin-mocha-light-cursors.zip\" -d \"/home/$SUDO_USER/.icons\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/.icons\"" "Install Catppuccin Hyprcursor" "yes" "no"

# -------------------- Papirus Icons theme + Catppuccin --------------------
run_command "wget -qO- https://git.io/papirus-icon-theme-install | sh && sudo -u \"$SUDO_USER\" git clone https://github.com/catppuccin/papirus-folders.git \"/home/$SUDO_USER/papirus-folders\" && cp -r \"/home/$SUDO_USER/papirus-folders/src\"/* /usr/share/icons/Papirus && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/papirus-folders\" && sudo -u \"$SUDO_USER\" bash -lc 'cd /home/$SUDO_USER && curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders && ./papirus-folders -C cat-mocha-blue --theme Papirus-Dark && rm -f ./papirus-folders'" "Papirus install + Catppuccin Mocha Blue" "yes" "no"

# -------------------- Catppuccin Kvantum Theme --------------------
run_command "mkdir -p \"/home/$SUDO_USER/Documents/Cat\" && cp -r \"$BASE_DIR/assets/themes/catppuccin-mocha-blue\" \"/home/$SUDO_USER/Documents/Cat\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/Documents/Cat\"" "Kvantum: copia tema Catppuccin" "yes" "no"

# -------------------- Fonts --------------------
run_command "fc-cache -fv" "Refresh font cache" "yes" "no"

# -------------------- Rebuild bat cache (catppuccin mocha) --------------------
run_command "bat cache --build" "Rebuild bat syntax highlighting cache" "yes" "no"

# -------------------- Firewall setup (UFW) --------------------
run_command "ufw default deny incoming && ufw default allow outgoing && ufw --force enable && systemctl enable ufw" "Configura e abilita UFW" "yes"

# -------------------- Set default shell + Oh My Zsh --------------------
run_command "chsh -s /usr/bin/zsh \"$SUDO_USER\" && sudo -u \"$SUDO_USER\" RUNZSH=no CHSH=no sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"" "Set Zsh + install Oh My Zsh" "yes" "no"

# -------------------- Neovim setup --------------------
run_command "sudo -u \"$SUDO_USER\" git clone https://github.com/LazyVim/starter \"/home/$SUDO_USER/.config/nvim\" && sudo -u \"$SUDO_USER\" rm -rf \"/home/$SUDO_USER/.config/nvim/.git\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/.config/nvim\"" "Neovim: LazyVim starter (+cleanup)" "yes" "no"

# -------------------- Pacman Configuration --------------------
run_command "cp \"$BASE_DIR/assets/pacman.conf\" /etc/pacman.conf" "Copy pacman.conf to /etc for $SUDO_USER" "yes" "no"

# -------------------- Override Autologin --------------------
run_command "mkdir -p /etc/systemd/system/getty@tty1.service.d && cp \"$BASE_DIR/assets/override.conf\" /etc/systemd/system/getty@tty1.service.d" "Systemd override autologin" "yes" "no"

# -------------------- .zprofile for uwsm autologin --------------------
run_command "cp \"$BASE_DIR/assets/.zprofile\" \"/home/$SUDO_USER/\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/.zprofile\"" "Copy zprofile configuration" "yes" "no"

# -------------------- Starship Configuration --------------------
run_command "cp \"$BASE_DIR/assets/starship.toml\" \"/home/$SUDO_USER/.config/\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/.config/starship.toml\"" "Copy Starship configuration" "yes" "no"

# -------------------- Wallpapers --------------------
run_command "mkdir -p \"/home/$SUDO_USER/Pictures/wallpapers\" && cp \"$BASE_DIR/assets/wallpapers/wallhaven-3qzvr6.png\" \"/home/$SUDO_USER/Pictures/wallpapers\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/Pictures/wallpapers\"" "Wallpapers: crea dir + copia + chown" "yes" "no"

# -------------------- Swww current Wallpaper --------------------
run_command "mkdir -p \"/home/$SUDO_USER/.cache\" && cp -r \"$BASE_DIR/assets/swww\" \"/home/$SUDO_USER/.cache/\" && chown -R \"$SUDO_USER:$SUDO_USER\" \"/home/$SUDO_USER/.cache/swww\"" "Swww cache: prepara cartella e contenuti" "yes" "no"

# -------------------- Fstab Configuration for SSD Auto Mount --------------------
FSTAB_ENTRY="# SSD Auto Mount\nUUID=0C1A3D631A3D4ACA /mnt/Dati ntfs3 defaults,noatime,nofail,windows_names,prealloc,uid=1000,gid=1000 0 0"
run_command "echo -e \"$FSTAB_ENTRY\" | tee -a /etc/fstab" "Add SSD auto-mount entry to /etc/fstab" "yes"

# -------------------- Reflector Configuration --------------------
run_command "mkdir -p /etc/xdg/reflector && cp \"$BASE_DIR/assets/reflector/reflector.conf\" /etc/xdg/reflector/reflector.conf && mkdir -p /etc/systemd/system/reflector.timer.d && cp \"$BASE_DIR/assets/reflector/override.conf\" /etc/systemd/system/reflector.timer.d/override.conf && systemctl daemon-reload && systemctl enable reflector.timer" "Setup and enable reflector timer" "yes" "no"

# -------------------- Snapper + Snap-pac Configuration --------------------
run_command "mkdir -p /etc/snapper/configs && cp \"$BASE_DIR/assets/snap/root\" /etc/snapper/configs/root && cp \"$BASE_DIR/assets/snap/snap-pac.ini\" /etc/snap-pac.ini && systemctl enable --now snapper-cleanup.timer" "Snapper + snap-pac: copy & enable timer" "yes" "no"

# -------------------- Mkinitcpio & Nvidia Configuration (BEFORE driver installation) --------------------
run_command "mkdir -p /etc/modprobe.d && cp \"$BASE_DIR/assets/nvidia.conf\" /etc/modprobe.d/nvidia.conf && cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.backup && sed -i 's/^MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm btrfs)/' /etc/mkinitcpio.conf && sed -i 's/filesystems\\s\\+/filesystems btrfs-overlayfs /' /etc/mkinitcpio.conf" "Mkinitcpio + modprobe: prep NVIDIA + btrfs-overlayfs" "yes" "no"

print_success "Kernel configuration prepared. NVIDIA drivers will trigger initramfs rebuild automatically."

# -------------------- NVIDIA Drivers Installation (due comandi separati) --------------------
print_bold_blue "\n=== Installing NVIDIA Drivers ==="
print_info "The installation will automatically compile DKMS modules and rebuild initramfs..."
run_command "pacman -S --noconfirm --needed linux-headers nvidia-open-dkms nvidia-utils libva libva-utils lib32-nvidia-utils libva-nvidia-driver egl-wayland mesa lib32-mesa" "Install Nvidia Open DKMS (will auto-run mkinitcpio)" "yes"
run_command "pacman -S --noconfirm --needed lact && systemctl enable --now lactd" "Install LACT for GPU" "yes"

print_success "NVIDIA drivers installed and initramfs rebuilt automatically!"

# -------------------- Post-install instructions --------------------
print_info "\nPost-installation instructions:"
print_bold_blue "Set themes and icons:"
echo "   - Run 'nwg-look' and set the global GTK and icon theme"
echo "   - Open 'kvantummanager' (run with sudo for system-wide changes) to select and apply the Catppuccin theme"
echo "   - Open 'qt6ct' and 'qt5ct' to set Kvantum style"
echo "------------------------------------------------------------------------"
