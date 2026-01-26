#############################################################
# ZSH ONLY
#############################################################

# Autoload compinit before anything else
autoload -Uz compinit
compinit

# Also enable brew if on mac
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load shared config
[ -f ~/.shell_common ] && source ~/.shell_common
[ -f ~/.zsh_setup ] && source ~/.zsh_setup

#############################################################
# Enable completion system
#############################################################
autoload -Uz compinit
compinit

bindkey -e 

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word


#############################################################
# Zsh history configuration (bash equivalents)
#############################################################
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
HISTSIZE=5000
SAVEHIST=10000

#############################################################
# Prompt (zsh-native)
#############################################################
PROMPT='%F{208}%n%f【=◈ ◡ ◈ =】%F{87}%m%f:%F{216}%~%f'

if [[ "$SESSION_TYPE" != "local" ]]; then
    PROMPT="$PROMPT %F{155}[${SESSION_TYPE}]%f"
fi

PROMPT="$PROMPT "

#############################################################
# FZF zsh init
#############################################################
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

