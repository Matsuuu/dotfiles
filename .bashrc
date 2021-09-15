case $- in
    *i*) ;;
      *) return;;
esac

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# EXPORTS
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs -g "!{node_modules,.git,.idea,target,dist,out-tsc}"'
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GRAALVM_HOME=$HOME/Tools/graalvm/graalvm-ce-java11-21.1.0
export VISUAL=nvim
export EDITOR="$VISUAL"
export NPM_PACKAGES="${HOME}/.npm-packages"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk/"
export TERM=xterm-256color
export BROWSER=/usr/bin/google-chrome-stable


# PATHS
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/Tools/clojure-lsp"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$GRAALVM_HOME/bin"

#jdtl support for nvim
export JDTLS_HOME=$HOME/Tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository
#export JAR=$HOME/Tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.200.v20210416-2027.jar
#export JDTLS_CONFIG=$HOME/Tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux
#export GRADLE_HOME=$HOME/gradle
export WORKSPACE=$HOME/workspace


function catclip() {
    cat $1 | xclip -selection clipboard $OUTPUT
}

function mp4towebp() {
    ffmpeg -i "$1" -vcodec libwebp -filter:v fps=fps=20 -lossless 0 -loop 0 -preset ${2:-default} -an -compression_level 6 -vsync 0 "${1/mp4/webp}"
}

# Tmux on startup
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

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
alias whathaveibeenupto="git log --author=\"$(git config user.email)\" --pretty=format:\"%C(magenta)%an%Creset %C(green)%<(20)%ar%Creset  %C(blue) %s %Creset\" --no-merges"
# I'm a sloppy shit aliases
alias tmus="tmux"
#
# Dev aliases
alias devserver="npx @web/dev-server --node-resolve --watch"
alias installanalyzer="npm i -D @custom-elements-manifest/analyzer"
# I'm a lazy shit aliases
alias vimplugins="vim ~/.vim/rcfiles/plugins.vim"
alias vimrc="vim ~/.vimrc"


#
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.npm_completion
