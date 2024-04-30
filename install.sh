#!/usr/bin/env bash

set -u
here=$(cd "$(dirname "$0")" || exit; pwd)
for f in .??*; do
  [[ "$f" = .git* ]] && continue
  [[ "$f" = .config ]] && continue
  [[ "$f" = .local ]] && continue
  case "$OSTYPE" in
  darwin*)
    ln -snfvF "$here"/"$f" ~/"$f"
    ;;
  linux*)
    ln -snfvT "$here"/"$f" ~/"$f"
    ;;
  esac
done
case "$OSTYPE" in
darwin*)
  ln -snfvF "$here"/.config/nvim/init.vim ~/.config/nvim/init.vim
  ;;
linux*)
  ln -snfvT "$here"/.config/nvim/init.vim ~/.config/nvim/init.vim
  ;;
esac

