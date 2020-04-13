# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ubukata/project/dotfiles/.vim/pack/mypackage/start/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ubukata/project/dotfiles/.vim/pack/mypackage/start/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ubukata/project/dotfiles/.vim/pack/mypackage/start/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ubukata/project/dotfiles/.vim/pack/mypackage/start/fzf/shell/key-bindings.zsh"
