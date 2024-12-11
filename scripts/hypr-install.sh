#!/usr/bin/env bash

PACKAGES="
hyprland
hyprpaper
hyprlock
hypridle
xdg-desktop-portal-hyprland
xdg-desktop-portal-gtk
wlr-randr
waybar
dunst
rofi-wayland
blueman
"

sudo pacman -S --noconfirm --needed $PACKAGES
