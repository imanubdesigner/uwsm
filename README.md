# ❄️ Hypruccin — Matugen Edition (Dynamic Aesthetics)

> “Where performance meets the evolving shades of your wallpaper — powered by Matugen.”  
> — *by Manu*

---

## 🌿 Introduction

**Hypruccin (Matugen Edition)** is a high-performance Arch Linux configuration that takes the core of **Hyprland** and **UWSM** to the next level through dynamic automation. 

A differenza della versione base incentrata sui colori statici di Catppuccin, questo branch utilizza **[Matugen](https://github.com/InioX/matugen)** come motore estetico principale. Il sistema non è più vincolato a una palette fissa, ma genera i colori dell'intera interfaccia (Waybar, Ghostty, Mako, etc.) in tempo reale basandosi sul wallpaper scelto.

A huge thanks to **[DHH](https://github.com/dhh)** and his collaborators for their inspiring work on **[Omarchy](https://github.com/basecamp/omarchy)** — their dedication inspired the automation layer of this project.

---

## 🧩 Dynamic Core Stack

| Component          | Description                                                  | Link                                                         |
| :----------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 🧠 **Hyprland**     | Dynamic tiling Wayland compositor — the heart of the system. | [GitHub](https://github.com/hyprwm/Hyprland)                 |
| ⚙️ **UWSM**         | Universal Wayland session manager, handling daemons and startup. | [GitHub](https://github.com/Vladimir-csp/uwsm)               |
| 🌈 **Matugen**      | **The Aesthetic Engine:** Material You color generation for Wayland. | [GitHub](https://github.com/InioX/matugen)                   |
| 👻 **Ghostty**      | Next-gen terminal, now with dynamic Matugen color schemes.   | [Site](https://mitchellh.com/ghostty)                        |
| 🎨 **Mako**         | Notification daemon with colors automatically synced via Matugen. | [GitHub](https://github.com/emersion/mako)                   |
| 🚀 **Walker**       | Application launcher styled dynamically to match your wallpaper. | [GitHub](https://github.com/abenz1267/walker)                |
| 🧱 **Waybar**       | Modular status bar using Matugen CSS variables for total harmony. | [GitHub](https://github.com/Alexays/Waybar)                  |
| 📁 **Yazi**         | Modern TUI file manager with blazing fast previews.          | [GitHub](https://github.com/sxyazi/yazi)                     |
| 📝 **Neovim**       | My main editor setup, powered by [**LazyVim**](https://github.com/LazyVim/LazyVim). | [GitHub](https://github.com/neovim/neovim)                   |
| 🔊 **PipeWire**     | The modern multimedia backbone for system audio.             | [Site](https://pipewire.org/)                                |
| 🎚️ **SwayOSD**      | Sleek OSD for volume/brightness, integrated into the dynamic theme. | [GitHub](https://github.com/ErikReider/SwayOSD)              |
| 📺 **Share Picker** | Hyprland utility for seamless window and screen sharing.     | [GitHub](https://github.com/WhySoBad/hyprland-preview-share-picker) |

---

## 🛠️ Utilities & Enhancements

* 🐱 [**Bat**](https://github.com/sharkdp/bat) + [**Bat-extras**](https://github.com/eth-p/bat-extras): Replacement for `cat` with syntax highlighting.
* 📊 [**Btop**](https://github.com/aristocratos/btop): Visual resource monitor in terminal.
* 🎵 [**Cava**](https://github.com/karlstav/cava): Real-time audio visualizer with dynamic color support.
* 🐘 [**Elephant**](https://github.com/abenz1267/elephant): Backend search and indexing engine for Walker.
* ⚡ [**Fastfetch**](https://github.com/fastfetch-cli/fastfetch): System info fetch tool, themed dynamically by Matugen.
* 🌐 [**Fcitx5**](https://github.com/fcitx/fcitx5): Input method framework for multilingual and emoji support.
* 🔍 [**Fzf**](https://github.com/junegunn/fzf): Blazing-fast fuzzy finder used in scripts.
* 🖼️ [**Waypaper**](https://github.com/anufrievroman/waypaper): Wallpaper manager that triggers Matugen on change.
* 🌄 [**Awww**](https://github.com/LGFae/swww): Wallpaper daemon (formerly swww) providing smooth transitions.
* 🌄 [**Gowall**](https://github.com/Achno/gowall): Used for pre-processing wallpapers before Matugen generation.
* 🔊 [**WirePlumber**](https://pipewire.pages.freedesktop.org/wireplumber/): Session manager for PipeWire.
* 🎹 [**PulseAudio**](https://www.freedesktop.org/wiki/Software/PulseAudio/): Compatibility layer for full app audio support.

---
