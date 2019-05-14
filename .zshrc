export LESSCHARSET=utf-8

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

PROMPT=%#

stty stop undef
stty start undef
