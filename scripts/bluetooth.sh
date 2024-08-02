#!/bin/bash

sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack -y --needed
sudo pacman -S pipewire-media-session bluez bluez-utils -y --needed

systemctl --user enable --now pipewire pipewire-pulse
systemctl --user start pipewire pipewire-pulse

sudo systemctl enable --now bluetooth
sudo systemctl start bluetooth