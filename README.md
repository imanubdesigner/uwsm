# ❄️ Hypruccin — Matugen Edition (Dynamic Aesthetics)

> “Where performance meets the evolving shades of your wallpaper — powered by Matugen.”  
> — *by Manu*

---

## 🌿 Introduction

**Hypruccin (Matugen Edition)** is a high-performance Arch Linux configuration that takes the core of **Hyprland** and **UWSM** to the next level through dynamic automation. 

## 🎨 Material Sophistication: The Matugen Integration

Departing from the static, predefined color palettes of the standard **Catppuccin** release, this branch introduces a sophisticated architectural pivot by employing **[Matugen](https://github.com/InioX/matugen)** as its primary aesthetic engine. 

The environment is no longer tethered to a fixed chromatic range; instead, it embraces a **reactive design philosophy**. By leveraging material design algorithms, the system performs a real-time analysis of your desktop wallpaper to orchestrate a harmonious color spectrum across the entire ecosystem—from **Waybar** and **Ghostty** to **Mako** and beyond.

### 💎 Key Features & Enhancements

* **Algorithmic Fluidity:** Rather than selecting from a list of hard-coded themes, the ambiance is dictated by your imagery. The system dynamically generates an optimized palette, ensuring that contrast ratios and visual hierarchy remain impeccable and accessible.
* **System-Wide Synchronicity:** Matugen acts as the centralized "source of truth." A single wallpaper change triggers a recursive update across all configuration files, instantly re-skinning your terminal, bars, and notification daemons to achieve a unified visual identity.
* **Transcending the Static:** While the layout retains the elegant DNA of the original project, this implementation liberates the user from the constraints of fixed hex values. It transforms your Hyprland setup into a living canvas that evolves alongside your aesthetic choices.
* **Performance-Oriented Automation:** The transition logic is engineered for minimal latency, ensuring that the computational process of generating and injecting new themes is virtually imperceptible and seamless.

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
