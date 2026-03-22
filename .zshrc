########################################
# Powerlevel10k Instant Prompt (TOP)
########################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# Oh My Zsh Base
########################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  sudo
  jsontools
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

########################################
# Core Tooling (order matters)
########################################

# zoxide (must be after OMZ)
eval "$(zoxide init zsh)"
# Better zoxide completion behavior
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# direnv
eval "$(direnv hook zsh)"

# fzf (keybindings + completion)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########################################
# Keybindings
########################################
bindkey -v

# word navigation
bindkey '^[^?' backward-kill-word
bindkey '^[d' kill-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^d' delete-char

########################################
# Completion / fzf-tab tuning
########################################
zstyle ':completion:*' menu select
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

########################################
# History
########################################
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_ignore_all_dups
setopt share_history

########################################
# Safety / UX
########################################
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
setopt noclobber

########################################
# Environment
########################################
export EDITOR="nvim"
export DIRENV_LOG_FORMAT=""

########################################
# Homebrew (Apple Silicon safe)
########################################
eval "$(/opt/homebrew/bin/brew shellenv)"

########################################
# PATH (deduplicated, ordered)
########################################
path=(
  /opt/homebrew/opt/gcc/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/.starkli/bin
  $HOME/.bb
  $HOME/.opencode/bin
  $HOME/.antigravity/antigravity/bin
  /opt/homebrew/opt/openjdk@21/bin
  /opt/homebrew/opt/ruby/bin
  $path
)

export PATH

########################################
# Java
########################################
export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"

########################################
# PNPM
########################################
export PNPM_HOME="$HOME/Library/pnpm"
path=($PNPM_HOME $path)

########################################
# Nargo
########################################
export NARGO_HOME="$HOME/.nargo"
path=($NARGO_HOME/bin $path)

########################################
# ASDF
########################################
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

########################################
# Aliases
########################################
alias ls='ls --color'
alias lg='lazygit'
alias python='python3'
alias tmux='tmux -u'

# zoxide navigation
alias cd='z'
alias cdi='zi'

if command -v bat &>/dev/null; then
  alias cat="bat"
fi
########################################
# Angular completion
########################################
if command -v ng >/dev/null 2>&1; then
  source <(ng completion script)
fi

########################################
# Scarb completion (safe)
########################################
if command -v scarb >/dev/null 2>&1; then
  eval "$(scarb completions zsh)"
fi

########################################
# Local env loaders
########################################
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.starkli/env" ]] && . "$HOME/.starkli/env"

########################################
# Colors
########################################
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

########################################
# Powerlevel10k config (BOTTOM)
########################################
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# Secrets
########################################
[[ -f "$HOME/.secrets/github" ]] && source "$HOME/.secrets/github"
export PATH="/Users/shaurya/.bb:$PATH"

