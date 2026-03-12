#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT_DIR/wallctl"

if [[ ! -f "$SRC" ]]; then
  echo "wallctl source not found at $SRC" >&2
  exit 1
fi

TARGET_DIR="/usr/local/bin"
if [[ -d "$TARGET_DIR" && -w "$TARGET_DIR" ]]; then
  :
else
  TARGET_DIR="$HOME/.local/bin"
  mkdir -p "$TARGET_DIR"
fi

install -m 0755 "$SRC" "$TARGET_DIR/wallctl"

echo "Installed wallctl to: $TARGET_DIR/wallctl"
if [[ "$TARGET_DIR" == "$HOME/.local/bin" ]]; then
  echo "If needed, add this to your shell profile:"
  echo "  export PATH=\"$HOME/.local/bin:$PATH\""
fi

echo "Run: wallctl help"
