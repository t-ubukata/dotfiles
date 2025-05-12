if [[ ! "$PATH" == *"$HOME"/.local/bin* ]]; then
  export PATH="$HOME/.local/bin${PATH:+:${PATH}}"
fi
export LESSCHARSET=utf-8
export VISUAL=vi
export EDITOR=vi
export LESSEDIT="vi %f"
export FZF_DEFAULT_COMMAND=fd

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
alias gr='grep -RIn --color=auto'
alias python='python3'
alias py='python3'
alias tm='tmux -2u'
alias gs='git status'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit'
alias gf='git fetch'
alias gpl='git pull'
alias gps='git push'
alias gl='git log'
alias gdb="gdb -q"

case "$OSTYPE" in
darwin*)
  export LANG=en_US.UTF-8
  alias l='ls -ahlFG'
  # Source iff interactive 
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
  ;;
linux*)
  export LANG=C.UTF-8
  export DEBIAN_FRONTEND=noninteractive
  alias l='ls -ahlF --color=auto'
  alias fd='fdfind'
  eval "$(dircolors -b)"
  # Source iff interactive 
  [[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/completion.zsh" 2> /dev/null
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
  ;;
esac

