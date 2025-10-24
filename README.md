# 🪶 HyprNest — A Modern Arch Linux + Hyprland-UWSM Setup

> “Minimal, fast, elegant — built for focus and beauty.”  
> — *by Manu*

---

## 🌿 Introduction

**HyprNest** is my personal and evolving Arch Linux configuration, designed around **[Hyprland](https://github.com/hyprwm/Hyprland)** and managed via **[UWSM (Universal Wayland Session Manager)](https://github.com/Aylur/uwsm)**.  
It’s a cohesive, aesthetic, and highly responsive desktop environment that balances **efficiency**, **clarity**, and **style**.

A huge thanks to **[DHH](https://github.com/dhh)** and his collaborators for their inspiring work on **[Omarchy](https://github.com/basecamp/omarchy)** —  
their dedication and open design philosophy inspired me to build upon those foundations with my own workflow, visual identity, and automation layer.

---

## 🧩 Core Stack

| Component | Description |
|------------|-------------|
| 🧠 [**Hyprland**](https://github.com/hyprwm/Hyprland) | Dynamic tiling Wayland compositor — the heart of the system. |
| ⚙️ [**UWSM**](https://github.com/Aylur/uwsm) | Universal Wayland session manager, handling daemons and startup services. |
| 🖥️ [**Kitty**](https://github.com/kovidgoyal/kitty) | Fast, GPU-accelerated terminal emulator with a clean aesthetic. |
| 📝 [**Neovim**](https://github.com/neovim/neovim) + [**LazyVim**](https://github.com/LazyVim/LazyVim) | My main editor setup (custom plugins coming soon). |
| 🐱 [**Bat**](https://github.com/sharkdp/bat) + [**Bat-extras**](https://github.com/eth-p/bat-extras) | Syntax-highlighted replacement for `cat`, with extended utilities. |
| 📊 [**Btop**](https://github.com/aristocratos/btop) | Modern resource monitor in terminal, minimal and visual. |
| 🎵 [**Cava**](https://github.com/karlstav/cava) | Real-time audio visualizer integrated into terminal and bar. |
| 🔔 [**Dunst**](https://github.com/dunst-project/dunst) | Simple, lightweight notification daemon. |
| 🐘 [**Elephant**](https://github.com/ErikReider/elephant) | Backend search and indexing engine for Walker. |
| 🚀 [**Walker**](https://github.com/ErikReider/walker) | Application launcher and menu system, styled with Catppuccin Mocha. |
| ⚡ [**Fastfetch**](https://github.com/fastfetch-cli/fastfetch) | Modern system information fetch tool, themed for HyprNest. |
| 🌐 [**Fcitx5**](https://github.com/fcitx/fcitx5) | Input method framework for multilingual and emoji support. |
| 🔍 [**Fzf**](https://github.com/junegunn/fzf) | Blazing-fast fuzzy finder used in scripts and menus. |
| 🧱 [**Waybar**](https://github.com/Alexays/Waybar) | Status bar displaying system info, audio, and workspace indicators. |
| 🖼️ [**Waypaper**](https://github.com/nwg-piotr/waypaper) | Wallpaper manager with seamless Swww integration. |
| 📁 [**Yazi**](https://github.com/sxyazi/yazi) | TUI file manager with modern navigation and previews. |
| 🌄 [**Gowall**](https://github.com/GowallApp/gowall) | Minimal wallpaper changer integrated with HyprNest. |

---

## 🧰 Post-Install Script

To install all required packages and providers for HyprNest:

```bash
yay -S --sudoloop --noconfirm \
walker-bin elephant-bin \
elephant-bluetooth-bin elephant-calc-bin elephant-clipboard-bin \
elephant-desktopapplications-bin elephant-files-bin elephant-menus-bin \
elephant-providerlist-bin elephant-runner-bin elephant-symbols-bin \
elephant-todo-bin elephant-unicode-bin elephant-websearch-bin \
waypaper gowall qview kitty neovim bat bat-extras btop cava dunst fastfetch \
fcitx5 fzf waybar yazi limine-mkinitcpio-hook limine-snapper-sync

