#!/usr/bin/env bash

set -u
here=$(cd "$(dirname "$0")" || exit; pwd)
for f in .??*; do
  [[ "$f" = .git* ]] && continue
  ln -snfvT "$here"/"$f" ~/"$f"
done
