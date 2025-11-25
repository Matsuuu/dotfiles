#############################################################
# BASH ONLY
#############################################################

# Load shared config
[ -f ~/.shell_common ] && source ~/.shell_common

#############################################################
# Bash History
#############################################################
HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=10000

shopt -s histappend
shopt -s checkwinsize

#############################################################
# Start bash completion
#############################################################
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#############################################################
# Bash prompt (ANSI safe)
#############################################################
PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;208m\]\u\[$(tput sgr0)\]【=◈ ◡ ◈ =】\[$(tput sgr0)\]\[\033[38;5;87m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;216m\]\w\[$(tput sgr0)\]'

if [ "$SESSION_TYPE" != "local" ]; then
    PS1="$PS1 \[$(tput setaf 155)\]\[[$SESSION_TYPE]\]\[$(tput sgr0)\]"
fi

PS1="$PS1$ "

#############################################################
# Bash-only readline tweaks
#############################################################
bind 'set show-all-if-ambiguous on'

#############################################################
# fzf bash initialization
#############################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

