#!/bin/bash

DOWNLOADS_DIR=~/Downloads
RUST_CHANNEL=stable

sudo pacman -S --needed base-devel rustup

rustup default $RUST_CHANNEL
rustup update $RUST_CHANNEL
rustup override set $RUST_CHANNEL

if [ -d "$DOWNLOADS_DIR" ]; then
	cd $DOWNLOADS_DIR
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
	paru -Syy
else
	echo "The directory $DOWNLOADS_DIR not exists."
	exit 1
fi
