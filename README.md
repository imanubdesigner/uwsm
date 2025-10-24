# 🪶 HyprNest — A Modern Arch Linux + Hyprland-UWSM Setup

> “Minimal, fast, elegant — built for focus and beauty.”  
> — *by Manu*

---

## 🌿 Introduction

**HyprNest** is my personal and evolving Arch Linux configuration, designed around **Hyprland** and managed via **UWSM (Universal Wayland Session Manager)**.  
It’s a cohesive, aesthetic, and highly responsive desktop environment that aims to balance **efficiency**, **clarity**, and **style**.

A huge thanks goes to **DHH** and his collaborators for their incredible work on **Omarchy** —  
their dedication and open design philosophy inspired me to create this refined setup.  
**HyprNest** builds upon those foundations, adding my own workflow, design language, and automation tools.

---

## 🧩 Core Stack

| Component | Description |
|------------|-------------|
| **Hyprland** | Dynamic tiling Wayland compositor — the heart of the system. |
| **UWSM** | Universal Wayland session manager, handling daemons and startup services. |
| **Kitty** | Fast, GPU-accelerated terminal emulator with a clean aesthetic. |
| **Neovim + LazyVim** | My main editor setup, using LazyVim as a base (custom plugin list coming soon). |
| **Bat & Bat-extras** | Syntax-highlighted replacement for `cat`, with extended utilities. |
| **Btop** | Modern resource monitor in terminal, minimal and visual. |
| **Cava** | Real-time audio visualizer, integrated into my terminal and bar. |
| **Dunst** | Simple, lightweight notification daemon. |
| **Elephant** | Backend search and indexing engine for Walker. |
| **Walker** | My primary launcher and control menu, styled with Catppuccin Mocha. |
| **Fastfetch** | Modern system information fetch tool, themed for HyprNest. |
| **Fcitx5** | Input method framework for multilingual and emoji support. |
| **Fzf** | Blazing-fast fuzzy finder used across my scripts and menus. |
| **Waybar** | Status bar displaying system info, audio, and workspace indicators. |
| **Waypaper** | Wallpaper manager with seamless Swww integration. |
| **Yazi** | TUI file manager with modern navigation and preview system. |
| **Gowall** | Minimal wallpaper changer integrated with my workflow. |

---

## 🧰 Post-Install Script

A single command installs all the utilities and providers required for HyprNest:

```bash
yay -S --sudoloop --noconfirm \
walker-bin elephant-bin \
elephant-bluetooth-bin elephant-calc-bin elephant-clipboard-bin \
elephant-desktopapplications-bin elephant-files-bin elephant-menus-bin \
elephant-providerlist-bin elephant-runner-bin elephant-symbols-bin \
elephant-todo-bin elephant-unicode-bin elephant-websearch-bin \
waypaper gowall qview kitty neovim bat bat-extras btop cava dunst fastfetch \
fcitx5 fzf waybar yazi limine-mkinitcpio-hook limine-snapper-sync

