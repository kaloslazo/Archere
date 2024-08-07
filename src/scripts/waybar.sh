#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WAYBAR_PATH="$CURRENT_DIR/../config/waybar"
WAYBAR_DEST=~/.config/waybar

if [[ ! -d $WAYBAR_DEST ]]; then
  mkdir -p $WAYBAR_DEST
fi

if [[ ! -f "$WAYBAR_DEST/config.jsonc" ]]; then
  ln -s "$WAYBAR_PATH/config.jsonc" "$WAYBAR_DEST/config.jsonc"
fi

if [[ ! -f "$WAYBAR_DEST/style.css" ]]; then
  ln -s "$WAYBAR_PATH/style.css" "$WAYBAR_DEST/style.css"
fi
