#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_BUILT="$ROOT_DIR/dist/wallctl"
SRC_SOURCE="$ROOT_DIR/wallctl"
LOCAL_BIN="$HOME/.local/bin"
LOCAL_PATH_EXPORT='export PATH="$HOME/.local/bin:$PATH"'

if [[ -f "$SRC_BUILT" ]]; then
  SRC="$SRC_BUILT"
else
  SRC="$SRC_SOURCE"
fi

if [[ ! -f "$SRC" ]]; then
  echo "wallctl source not found at $SRC" >&2
  exit 1
fi

ensure_local_bin_on_path() {
  if [[ ":$PATH:" == *":$LOCAL_BIN:"* ]]; then
    return 0
  fi

  local profiles=("$HOME/.zprofile" "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.bashrc" "$HOME/.profile")
  local p
  for p in "${profiles[@]}"; do
    if [[ -f "$p" ]] && grep -Fqs "$LOCAL_PATH_EXPORT" "$p"; then
      return 0
    fi
  done

  local target_profile="$HOME/.profile"
  case "${SHELL:-}" in
    */zsh) target_profile="$HOME/.zprofile" ;;
    */bash) target_profile="$HOME/.bash_profile" ;;
  esac

  {
    printf '\n# Added by wallctl installer\n'
    printf '%s\n' "$LOCAL_PATH_EXPORT"
  } >> "$target_profile"

  echo "Added PATH update to: $target_profile"
}

TARGET_DIR="/usr/local/bin"
if [[ -d "$TARGET_DIR" && -w "$TARGET_DIR" ]]; then
  :
else
  TARGET_DIR="$LOCAL_BIN"
  mkdir -p "$TARGET_DIR"
fi

install -m 0755 "$SRC" "$TARGET_DIR/wallctl"

echo "Installed wallctl to: $TARGET_DIR/wallctl"
if [[ "$SRC" == "$SRC_SOURCE" ]]; then
  echo "Note: using source script directly. Run ./build.sh first for clone-build-install flow."
fi
if [[ "$TARGET_DIR" == "$LOCAL_BIN" ]]; then
  ensure_local_bin_on_path
  echo "For this current terminal session, run:"
  echo "  $LOCAL_PATH_EXPORT"
fi

echo "Run: wallctl help"
