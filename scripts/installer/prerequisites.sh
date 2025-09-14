#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

# -------------------- Base setup --------------------
run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes"
run_command "pacman -S --noconfirm --needed git base-devel" "Install git and base-devel (needed for AUR and configs)" "yes"

# -------------------- Yay (AUR helper) --------------------
if command -v yay >/dev/null; then
  print_info "Skipping yay installation (already installed)."
else
  run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone YAY (Must)/Breaks the script" "no" "no"
  run_command "makepkg --noconfirm -si && cd .." "Build YAY (Must)/Breaks the script" "no" "no"
fi

# -------------------- Drivers --------------------
run_command "pacman -S --noconfirm linux-headers nvidia-open-dkms nvidia-utils libva libva-utils libva-nvidia-driver egl-wayland" "Install Nvidia Open DKMS" "yes"
run_command "pacman -S --noconfirm lact && systemctl enable --now lactd" "Install LACT for GPU" "yes"

# -------------------- Audio --------------------
run_command "pacman -S --noconfirm pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack alsa-utils alsa-plugins pamixer pavucontrol" "Install complete audio stack (PipeWire + utilities)" "yes"

# -------------------- Fonts --------------------
run_command "pacman -S --noconfirm ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols noto-fonts ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-droid noto-fonts-emoji otf-font-awesome adobe-source-code-pro-fonts" "Installing Nerd Fonts and Symbols (Recommended)" "yes"

# -------------------- Display manager & Network --------------------
run_command "pacman -S --noconfirm sddm && systemctl enable sddm.service" "Install and enable SDDM (Recommended)" "yes"
run_command "pacman -S --noconfirm networkmanager && systemctl enable NetworkManager.service" "Install and enable NetworkManager (Recommended)" "yes"
run_command "pacman -S --noconfirm wpa_supplicant && systemctl enable wpa_supplicant.service" "Install and enable WPA supplicant" "yes"

# -------------------- Bluetooth --------------------
run_command "pacman -S --noconfirm bluez bluez-utils blueman && systemctl enable bluetooth.service" "Install and enable Bluetooth (Recommended)" "yes"

# -------------------- Applications Installation --------------------
run_command "pacman -S --noconfirm ufw firefoxpwa wtype wf-recorder curl cmake ninja bat bat-extras yazi firefox obsidian neovim discord mpv yt-dlp spotify-launcher cava evince zsh zsh-completions zoxide fzf eza kitty imagemagick starship nano fastfetch ripgrep rofi rofi-emoji btop pacman-contrib tar xarchiver p7zip unrar unzip thunar tumbler libgepub libopenraw gvfs gvfs-mtp udisks2 xdg-user-dirs thunar-archive-plugin thunar-volman ffmpegthumbnailer ffmpeg poppler-glib librsvg" "Install complete application suite (browsers, media, development, system tools)" "yes"

# -------------------- Configuration Files --------------------

run_command "cp -r $BASE_DIR/configs/btop /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/btop" "Copy btop folder" "yes" "no"
run_command "cp -r $BASE_DIR/configs/cava /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/cava" "Copy Cava folder" "yes" "no"
run_command "cp -r $BASE_DIR/configs/kitty /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/kitty" "Copy Kitty Terminal folder" "yes" "no"
run_command "cp -r $BASE_DIR/configs/fastfetch /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/fastfetch" "Copy Fastfetch folder" "yes" "no"
run_command "cp -r $BASE_DIR/configs/rofi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/rofi && find /home/$SUDO_USER/.config/rofi -name '*.sh' -type f -exec chmod +x {} +" "Copy Rofi config and set permissions" "yes" "no"
run_command "cp -r $BASE_DIR/configs/yazi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/yazi" "Copy yazi folder" "yes" "no"
run_command "cp -r $BASE_DIR/configs/bat /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/bat" "Copy bat folder" "yes" "no"
run_command "cp -r $BASE_DIR/configs/fzf /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/fzf" "Copy fzf folder" "yes" "no"

echo "------------------------------------------------------------------------"
print_info "Prerequisites setup completed successfully!"
