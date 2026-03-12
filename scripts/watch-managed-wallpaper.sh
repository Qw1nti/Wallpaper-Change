#!/bin/zsh
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
exec zsh "$ROOT_DIR/wallctl" watch "$@"
