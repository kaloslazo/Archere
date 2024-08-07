#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_PATH="$CURRENT_DIR/../config/kitty/kitty.conf"
DEST_DIR=~/.config/kitty/

if [[ ! -d $DEST_DIR ]]; then
  mkdir $DEST_DIR
else
  echo "Directory $DEST_DIR already exists."
fi

if [ -f "$DEST_DIR/kitty.conf" ]; then
  echo "Dotfile $DEST_DIR/kitty.conf exists."
else
  ln -s "$CONFIG_PATH" "$DEST_DIR"
fi