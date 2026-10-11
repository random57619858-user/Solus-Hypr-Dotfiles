# Solus-Hypr-Dotfile

A basic Hyprland dotfile for **Solus**. It sets up a minimal, gruvbox-themed desktop: compositor, bar, launcher, terminal, wallpaper and a few tools so you can log in after a reboot and just use it.

This is a port of my own [Debian-Hypr-Dotfiles](https://github.com/random57619858-user/Debian-Hypr-Dotfiles) for Solus. The dotfiles themselves are identical; only the installer differs, using `eopkg` + Flatpak instead of `apt`.

<img width="1366" height="768" alt="imagen" src="https://github.com/user-attachments/assets/68700ec4-a07a-4609-94ae-e0b3281434b3" />

## ⚠️ About Solus

Unlike Debian, Solus doesn't require switching to unstable branches to get a modern setup. Hyprland is available directly in the repositories, and updates land once a week (usually Fridays) as part of Solus' curated rolling-release model.

PipeWire is already configured by default on Solus, so there's no need to enable it manually.

## Requirements

- A Solus installation
- `git` and `sudo` installed
- A working internet connection
- A bit of patience

## Installation

    git clone https://github.com/random57619858-user/Solus-Hypr-Dotfiles
    cd Solus-Hypr-Dotfiles
    chmod +x install.sh
    ./install.sh


## What it installs

Core desktop:

- Hyprland (compositor)
- Waybar (status bar)
- Rofi (app launcher and wallpaper picker)
- Kitty (terminal)
- Cava (audio visualizer)
- Hyprpaper (wallpaper daemon)

Extra tools:

- GDM (login manager)
- Wlogout (power menu)
- Hypridle + Hyprlock (idle and lock screen)
- Cliphist (clipboard history)
- Grim + Slurp + wl-clipboard (screenshots)
- XDG Desktop Portal Hyprland (screen sharing)
- Hyprpolkitagent (auth dialogs)
- Fluent icon theme
- JetBrainsMono Nerd Font

Optional (asked during install):

- Printer support (CUPS)
- Flatpak + Flathub
- Steam, Discord, OnlyOffice, VSCodium, OBS Studio (via Flatpak)

## Keybindings

    SUPER + Q              Open kitty
    SUPER + D              App launcher (rofi)
    SUPER + W              Change wallpaper
    SUPER + C              Close window
    SUPER + V              Toggle floating window
    SUPER + A              Clipboard history
    SUPER + L              Lock screen
    SUPER + 1-0            Switch workspace
    SUPER + SHIFT + 1-0    Move window to workspace
    SUPER + SHIFT + E      Power menu (wlogout)
    SUPER + Print          Screenshot

## Backups

The script asks before overwriting anything in `~/.config/`. If you say yes, a copy gets saved to `backup/` inside this repo.

It's not the best dotfile, but I hope you like it :)

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/9a6554fd-20c5-481c-9163-0b7872f84037" />
