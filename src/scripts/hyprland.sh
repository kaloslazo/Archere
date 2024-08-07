#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYPR_PATH="$CURRENT_DIR/../config/hyprland"
HYPR_DEST=~/.config/hypr

if [[ ! -d $HYPR_DEST ]]; then
  mkdir $HYPR_DEST
fi

if [ ! -f "$HYPR_DEST/hyprland.conf" ]; then
  ln -s "$HYPR_PATH/hyprland.conf" "$HYPR_DEST/hyprland.conf"
fi
