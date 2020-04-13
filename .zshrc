export LESSCHARSET=utf-8
export GOROOT=/usr/local/go
export GOPATH="$HOME"/.go
export PATH="$GOPATH"/bin:"$GOROOT"/bin:"$PATH"
export PATH="$HOME"/.cargo/bin:"$PATH"
export PATH="$HOME"/.local/bin:"$PATH"

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

bindkey -e
autoload -Uz colors
colors
autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit
prompt off
setopt auto_pushd
setopt pushd_ignore_dups
setopt nonomatch
setopt histignorealldups sharehistory
unsetopt promptcr

stty stop undef
stty start undef

zstyle :compinstall filename

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

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
  export LANG=C.UTF-8
  export DEBIAN_FRONTEND=noninteractive
  alias l='ls -ahlF --color=auto'
  ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
