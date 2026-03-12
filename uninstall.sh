#!/bin/zsh
set -euo pipefail

removed=0

for p in "/usr/local/bin/wallctl" "$HOME/.local/bin/wallctl"; do
  if [[ -f "$p" ]]; then
    rm -f "$p"
    echo "Removed: $p"
    removed=1
  fi
done

if [[ "$removed" -eq 0 ]]; then
  echo "No installed wallctl binary found in /usr/local/bin or ~/.local/bin"
fi
