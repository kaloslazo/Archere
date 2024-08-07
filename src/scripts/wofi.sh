#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WOFI_PATH="$CURRENT_DIR/../config/wofi"
WOFI_DEST=~/.config/wofi

if [[ ! -d $WOFI_DEST ]]; then
  mkdir -p $WOFI_DEST
fi
if [[ ! -f "$WOFI_DEST/config" ]]; then
  ln -s "$WOFI_PATH/config" "$WOFI_DEST/config"
fi
if [[ ! -f "$WOFI_DEST/style.css" ]]; then
  ln -s "$WOFI_PATH/style.css" "$WOFI_DEST/style.css"
fi
