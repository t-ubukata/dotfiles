#!/usr/bin/env bash

set -u
here=$(cd "$(dirname "$0")" || exit; pwd)
for f in .??*; do
  [[ "$f" = .git* ]] && continue
  ln -snfv "${here}"/"${f}" ~/"${f}"
done
