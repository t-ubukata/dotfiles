#!/usr/bin/env bash

set -u
here=$(cd "$(dirname "$0")" || exit; pwd)
for f in .??*; do
  [[ "$f" = .git* ]] && continue
  case "$OSTYPE" in
  darwin*)
    ln -snfvF "$here"/"$f" ~/"$f"
    ;;
  linux*)
    ln -snfvT "$here"/"$f" ~/"$f"
    ;;
  esac
done

