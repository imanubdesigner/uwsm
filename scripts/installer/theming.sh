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
run_command "mkdir -p /home/$SUDO_USER/.icons && tar -xvf $BASE_DIR/assets/icons/Nordzy-dark.tar.gz -C /home/$SUDO_USER/.icons && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.icons" "Install Nordzy Dark Icons" "yes" "no"
run_command "unzip -o $BASE_DIR/assets/hyprcursor/catppuccin-mocha-light-cursors.zip -d /home/$SUDO_USER/.icons && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.icons" "Install Catppuccin Hyprcursor" "yes" "no"
run_command "yay -S --sudoloop --noconfirm kvantum-theme-catppuccin-git" "Install Catppuccin theme for Kvantum" "yes" "no"

# -------------------- Fonts --------------------
run_command "fc-cache -fv" "Refresh font cache" "yes" "no"

# -------------------- Rebuild bat cache for catppuccin mocha theme --------------------
run_command "bat cache --build" "Rebuild bat syntax highlighting cache" "yes" "no"

# -------------------- Firewall setup --------------------
run_command "ufw default deny incoming" "Set UFW default policy: deny incoming" "yes"
run_command "ufw default allow outgoing" "Set UFW default policy: allow outgoing" "yes"
run_command "ufw enable" "Enable UFW firewall" "yes"

# -------------------- Set default shell --------------------
run_command "chsh -s /usr/bin/zsh $SUDO_USER" "Set default shell to zsh for user $SUDO_USER" "yes" "no"
run_command "sudo -u $SUDO_USER RUNZSH=no CHSH=no sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"" "Install Oh My Zsh for user $SUDO_USER" "yes" "no"

# -------------------- Neovim setup --------------------
run_command "git clone https://github.com/LazyVim/starter /home/$SUDO_USER/.config/nvim" "Clone LazyVim starter" "yes" "no"
run_command "rm -rf /home/$SUDO_USER/.config/nvim/.git" "Remove Git folder from LazyVim config" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/nvim" "Set correct ownership for Neovim config" "yes" "no"

# -------------------- SDDM Configuration --------------------
run_command "sudo cp $BASE_DIR/assets/sddm.conf /etc/sddm.conf" "Copy sddm.conf to /etc for manu user" "yes" "no"

# # -------------------- Thunar Configuration --------------------
# run_command "mkdir -p /home/$SUDO_USER/.config/xfce4" "Create XFCE4 config directory" "yes" "no"
# run_command "cp $BASE_DIR/assets/helpers.rc /home/$SUDO_USER/.config/xfce4/helpers.rc" "Copy helpers.rc to ~/.config/xfce4" "yes" "no"
# run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/xfce4/helpers.rc" "Set correct ownership for helpers.rc" "yes" "no"

# -------------------- Nautilus Open Any Terminal --------------------

# Definisce la directory target nella home dell'utente
USER_HOME=$(eval echo "~$SUDO_USER")
TARGET_DIR="$USER_HOME/nautilus-open-any-terminal"

# Clona il repository nella home dell'utente normale
run_command "sudo -u \"$SUDO_USER\" git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git \"$TARGET_DIR\"" \
  "Clone Nautilus Open Any Terminal repo into $TARGET_DIR" "yes" "no"

# Compila e installa nella stessa riga, come utente normale
run_command "sudo -u \"$SUDO_USER\" bash -c 'cd \"$TARGET_DIR\" && make && make install-nautilus schema'" \
  "Build and install Nautilus Open Any Terminal for $SUDO_USER" "yes" "no"

# Imposta Kitty come terminale predefinito per l’utente normale
run_command "sudo -u \"$SUDO_USER\" gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty" \
  "Set Kitty as default terminal for $SUDO_USER" "yes" "no"

# -------------------- Wallpapers --------------------
run_command "mkdir -p /home/$SUDO_USER/Pictures/wallpapers" "Create wallpapers directory" "yes" "no"
run_command "cp $BASE_DIR/assets/wallpapers/wallhaven-3qzvr6.png /home/$SUDO_USER/Pictures/wallpapers" "Copy the wallpaper to wallpapers directory" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Pictures/wallpapers" "Set correct ownership for wallpapers directory" "yes" "no"

# -------------------- Swww current Wallpaper --------------------
run_command "mkdir -p /home/$SUDO_USER/.cache" "Create a .cache" "yes" "no"
run_command "cp -r $BASE_DIR/assets/swww /home/$SUDO_USER/.cache/" "Copy swww cache folder for wallpaper" "yes" "no"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.cache/swww" "Set correct ownership on swww folder" "yes" "no"

# -------------------- Post-install instructions --------------------
print_info "\nPost-installation instructions:"
print_bold_blue "Set themes and icons:"
echo "   - Run 'nwg-look' and set the global GTK and icon theme"
echo "   - Open 'kvantummanager' (run with sudo for system-wide changes) to select and apply the Catppuccin theme"
echo "   - Open 'qt6ct' and 'qt5ct' to set Kvantum style"
echo "------------------------------------------------------------------------"
