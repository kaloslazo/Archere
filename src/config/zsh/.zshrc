# @AUTHOR: Kalos Lazo
# @GITHUB: kaloslazo

# >> zsh options
setopt extended_glob

# >> bindkeys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '\t\t' autosuggest-accept

# >> aliases
alias ls="exa --icons --grid"
alias cat="bat --theme='Catppuccin-mocha'"

alias gits='git status'
alias gita='git add'
alias gitc='git commit -m'
alias gom='git push origin main'
alias gitd='git diff'

# >> invoques
eval "$(starship init zsh)"

# >> plugin manager
source ~/.zplugins.zsh
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# >> export
export PATH="$HOME/.local/bin:$PATH"
