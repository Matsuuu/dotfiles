case $- in
    *i*) ;;
      *) return;;
esac
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
HISTSIZE=5000
HISTFILESIZE=10000

shopt -s histappend
shopt -s checkwinsize

PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;208m\]\u\[$(tput sgr0)\]【=◈ ◡ ◈ =】\[$(tput sgr0)\]\[\033[38;5;87m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;216m\]\w\[$(tput sgr0)\]\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

bind 'set show-all-if-ambiguous on'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PATHS
export PATH="~/.ebcli-virtual-env/executables:$PATH"
export PATH=~/.pyenv/versions/3.7.2/bin:$PATH

# EXPORTS
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs -g "!{node_modules,.git,.idea,target,dist,out-tsc}"'
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GRAALVM_HOME=$HOME/Tools/graalvm/
export VISUAL=vim
export EDITOR="$VISUAL"


# ALIASES
# Software overrides
alias python=python3.8
alias vim="nvim"
#
# I forget about how to do stuff aliases
alias filesize="du -sh"
alias whoisusingports="sudo lsof -i -P -n | grep LISTEN"
#
# Git aliases
alias prettylog="git log --graph --decorate --oneline"
alias whathaveibeenupto="git log --author=\"$(git config user.email)\" --pretty=format:\"%an, %ar : %s\" --no-merges"
#
# I'm a lazy shit aliases
alias vimplugins="vim ~/.vim/rcfiles/plugins.vim"
#
