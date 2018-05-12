HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e

zstyle :compinstall filename '/Users/admin/.zshrc'

autoload -Uz compinit
compinit

PROMPT=$

