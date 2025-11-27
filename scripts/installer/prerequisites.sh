#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

# -------------------- Base setup --------------------
run_command "pacman -S --noconfirm reflector" "Install Reflector" "yes"
run_command "sudo reflector --country Italy --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist" "Update Pacman mirrorlist with fresh, fast mirrors" "yes" "yes"
run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes"
run_command "pacman -Syu --noconfirm --needed git base base-devel" "Install git and base-devel (needed for AUR and configs)" "yes"

# -------------------- Yay (AUR helper) --------------------
if command -v yay >/dev/null; then
  print_info "Skipping yay installation (already installed)."
else
  run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone YAY (Must)/Breaks the script" "no" "no"
  run_command "makepkg --noconfirm -si && cd .." "Build YAY (Must)/Breaks the script" "no" "no"
fi

# -------------------- Network Configuration (iwd + systemd-networkd) --------------------

# Install iwd (Wi-Fi daemon) and Impala (TUI frontend)
run_command "pacman -S --needed --noconfirm iwd impala" "Install iwd and Impala" "yes"

# Create networkd directory and copy config file
run_command "sudo mkdir -p /etc/systemd/network && sudo cp $BASE_DIR/assets/20-ethernet.network /etc/systemd/network/" "Create networkd directory and copy config file" "yes"

# Enable all necessary services
run_command "systemctl enable iwd.service systemd-networkd.service systemd-resolved.service" "Enable network services" "yes"

# Prevent systemd from waiting for a network connection on boot
run_command "sudo systemctl disable systemd-networkd-wait-online.service && sudo systemctl mask systemd-networkd-wait-online.service" "Prevent networkd wait-online timeout" "yes"

# Configure DNS symlink
run_command "sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf" "Configure DNS symlink" "no"

# -------------------- Bluetooth --------------------
run_command "pacman -S --needed --noconfirm bluez bluez-utils bluetui && systemctl enable bluetooth.service" "Install and enable Bluetooth (Recommended)" "yes"

# -------------------- Applications Installation --------------------
run_command "pacman -S --needed --noconfirm imv lazygit ghostty android-tools swayosd mlocate snap-pac xsel ttf-nerd-fonts-symbols-mono woff2-font-awesome ttf-nerd-fonts-symbols noto-fonts ttf-jetbrains-mono-nerd noto-fonts-emoji otf-font-awesome adobe-source-code-pro-fonts pipewire wireplumber pipewire-audio sushi pipewire-alsa pipewire-pulse pipewire-jack alsa-utils alsa-plugins pamixer gnome-themes-extra nautilus nautilus-python gtk4 glib2 gobject-introspection gum ufw fcitx5 fcitx5-gtk fcitx5-qt jdk21-openjdk inotify-tools sassc meson wget cargo swww python-pyquery luarocks curl spotify-launcher nodejs npm tree-sitter tree-sitter-cli cmake ninja bat bat-extras yazi chromium obsidian neovim discord mpv yt-dlp cava evince zsh zsh-completions wiremix zoxide fzf eza imagemagick starship nano fastfetch ripgrep btop pacman-contrib tar p7zip unrar unzip libgsf libgepub libwebp libopenraw gvfs gvfs-mtp udisks2 xdg-user-dirs ffmpegthumbnailer ffmpeg poppler-glib librsvg qt6-imageformats qt5-imageformats" "Install complete application suite (browsers, media, development, system tools)" "yes"

# -------------------- Configuration Files --------------------
run_command "cp -r $BASE_DIR/configs/* /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config" "Copy all config folders" "yes" "no"

# -------------------- Yazi: plugin "bat" --------------------
run_command "mkdir -p /home/$SUDO_USER/.config/yazi/plugins" \
  "Create Yazi plugins dir" "yes" "no"

run_command "bash -lc 'if [ -d /home/$SUDO_USER/.config/yazi/plugins/bat.yazi/.git ]; then git -C /home/$SUDO_USER/.config/yazi/plugins/bat.yazi pull --ff-only; else git clone --depth 1 https://github.com/mgumz/yazi-plugin-bat.git /home/$SUDO_USER/.config/yazi/plugins/bat.yazi; fi'" \
  "Install/Update Yazi plugin: bat" "yes" "no"

# -------------------- Yazi Plugin Restore --------------------
run_command "sudo -u $SUDO_USER ya pkg install" \
  "Restore Yazi plugins from package.toml" "yes" "no"

echo "------------------------------------------------------------------------"
print_info "Prerequisites setup completed successfully!"
