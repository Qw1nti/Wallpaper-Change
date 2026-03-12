#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT_DIR/wallctl"
DIST_DIR="$ROOT_DIR/dist"
OUT="$DIST_DIR/wallctl"

if [[ ! -f "$SRC" ]]; then
  echo "wallctl source not found at $SRC" >&2
  exit 1
fi

zsh -n "$SRC"
mkdir -p "$DIST_DIR"
cp "$SRC" "$OUT"
chmod 0755 "$OUT"

echo "Build complete: $OUT"
