export LESSCHARSET=utf-8

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

bindkey -e
zstyle :compinstall filename
autoload -Uz colors
colors
autoload -Uz compinit
compinit
setopt auto_pushd
setopt pushd_ignore_dups
setopt nonomatch
unsetopt promptcr

PROMPT=%#

stty stop undef
stty start undef

alias grep='grep --color=auto'
alias diff='colordiff'
alias py='python3'
alias gs='git status'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit'
alias gpl='git pull'
alias gps='git push'
alias gl='git log'
alias gdb="gdb -q"

case "$OSTYPE" in
darwin*)
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  alias l='ls -ahlFG'
  ;;
linux*)
  export LC_ALL=C.UTF-8
  export LANG=en_C.UTF-8
  export DEBIAN_FRONTEND=noninteractive
  alias l='ls -ahlF --color=auto'
  ;;
esac
