#!/bin/sh

set -u
DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}
for f in .??*
do
  [ "$f" = ".DS_Store" ] && continue
  [ "$f" = ".Trash" ] && continue
  [ "$f" = ".bash_history" ] && continue
  [ "$f" = ".histfile" ] && continue
  [ "$f" = ".python_history" ] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
