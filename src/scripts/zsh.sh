#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_PATH="$CURRENT_DIR/../config/zsh/"
ZSH_FILE=~/.zshrc

[[ -d ${ZDOTDIR:-~}/.antidote ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

if [[ "$SHELL" != *"zsh" ]]; then
  chsh -s $(which zsh)
  ln -s "$ZSH_PATH/.zshrc" "$ZSH_FILE"

  # >> run post installation at zsh console for plugins
  source "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
  ln -s "$ZSH_PATH/.zsh_plugins.txt" "~/.zsh_plugins.txt"
  antidote bundle <"$HOME/.zsh_plugins.txt" >~/.zplugins.zsh
fi