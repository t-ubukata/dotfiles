export LESSCHARSET=utf-8
export DEBIAN_FRONTEND=noninteractive
export PYLINTRC=~/.config/pylintrc

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

bindkey -e
zstyle :compinstall filename
autoload -Uz colors
colors
autoload -Uz compinit
compinit
setopt auto_pushd
setopt pushd_ignore_dups

PROMPT=%#

stty stop undef
stty start undef

alias l='ls -ahlF --color=auto'
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
