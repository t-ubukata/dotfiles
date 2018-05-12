#!/bin/sh

set -u
DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}
for f in .??*
do
  [ "$f" = ".git" ] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
