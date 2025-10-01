# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Use Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable plugins
plugins=(
  git
  sudo
  jsontools
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# >>> zoxide initialization >>>
eval "$(zoxide init zsh)"
# <<< zoxide initialization <<<

# >>> direnv initialization >>>
eval "$(direnv hook zsh)"
# <<< direnv initialization <<<

# >>> fzf initialization >>>
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# <<< fzf initialization <<<

# Use vi keybindings
bindkey -v

# Tab completion settings
autoload -Uz compinit
compinit

# Set completion menu with fzf-tab
zstyle ':completion:*' menu select
zstyle ':fzf-tab:*' switch-group ',' '.'

# Improve history behavior
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_ignore_all_dups
setopt share_history

# Optional: quiet the Powerlevel10k instant prompt warning
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Prompt to confirm before overwriting files
setopt noclobber

# Use modern LS_COLORS
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Aliases
alias btop="btop --utf-force"
alias ls='ls --color'
alias lg='lazygit' 
alias python='python3'
alias tmux='tmux -u'
alias cd='z'
alias cdi='zi'

# Optional: use bat instead of cat if available
if command -v bat &>/dev/null; then
  alias cat="bat"
fi

# Add user-specific bin directories to path
export PATH="/opt/homebrew/opt/gcc/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export CC=gcc-15
export CXX=g++-15

# Enable direnv's auto `.envrc` loading
export DIRENV_LOG_FORMAT=""

# Editor
export EDITOR="nvim"

# Optional: enable completion for system paths
compinit -u

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Option + Delete → delete one word backward
bindkey '^[^?' backward-kill-word

# Option + Fn + Delete → delete one word forward
bindkey '^[d' kill-word

bindkey '^[[1;3D' backward-word

bindkey '^[[1;3C' forward-word

# Fn + Delete → delete one character forward
bindkey '^d' delete-char
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/shaurya/.lmstudio/bin"
# End of LM Studio CLI section



# Load Angular CLI autocompletion.
source <(ng completion script)
