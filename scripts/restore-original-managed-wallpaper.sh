#!/bin/zsh
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKUP="$ROOT_DIR/cchs-desktopWallpaper-default.backup.jpg"
exec zsh "$ROOT_DIR/wallctl" restore --path "$BACKUP" "$@"
