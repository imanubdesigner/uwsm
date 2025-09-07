#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for theming + services setup"
print_info "\nStarting theming and service setup..."

# -------------------- Theming --------------------
run_command "pacman -S --noconfirm nwg-look" "Install nwg-look for GTK theme management" "yes"
run_command "pacman -S --noconfirm qt5ct qt6ct kvantum kvantum-qt5" "Install Qt5/Qt6 and Kvantum theme engines" "yes"
run_command "mkdir -p /home/$SUDO_USER/.themes && unzip -o $BASE_DIR/assets/themes/Catppuccin-Dark-BL-MB.zip -d /home/$SUDO_USER/.themes && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.themes" "Install Catppuccin Dark BL MB GTK theme" "yes" "no"
run_command "mkdir -p /home/$SUDO_USER/.icons && tar -xvf $BASE_DIR/assets/icons/Tela-circle-dracula.tar.xz -C /home/$SUDO_USER/.icons && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.icons" "Install Tela Circle Dracula icon theme" "yes" "no"
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

# -------------------- Post-install instructions --------------------
print_info "\nPost-installation instructions:"
print_bold_blue "Set themes and icons:"
echo "   - Run 'nwg-look' and set the global GTK and icon theme"
echo "   - Open 'kvantummanager' (run with sudo for system-wide changes) to select and apply the Catppuccin theme"
echo "   - Open 'qt6ct' and 'qt5ct' to set Kvantum style"
echo "------------------------------------------------------------------------"
