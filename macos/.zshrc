eval "$(mise activate zsh)"

# Initialize the completion system
autoload -Uz compinit && compinit

# Case insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

alias ls="eza --icons --git"
alias cat="bat"

if [[ -z "$ZELLIJ" ]]; then
  fastfetch-random
  zellij --layout agent
fi

export _ZO_DOCTOR=0
eval "$(zoxide init zsh --cmd cd)"
