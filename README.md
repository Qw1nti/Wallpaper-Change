# wallctl

Portable macOS terminal app for setting desktop wallpaper from either an image file path or a directory.

## Install (Clone -> Build -> Install)

```bash
git clone https://github.com/Qw1nti/Wallpaper-Change.git
cd Wallpaper-Change
chmod +x wallctl build.sh install.sh uninstall.sh
./build.sh
./install.sh
```

`install.sh` will install the built artifact from `dist/wallctl` when available.
If `/usr/local/bin` is not writable, it installs to `~/.local/bin` and auto-adds that path to your shell profile.
For the current terminal session, run:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Quick Start

Run interactive mode:

```bash
wallctl
```

Or direct command:

```bash
wallctl set "/absolute/path/to/image-or-directory" --force-refresh
```

## Commands

```bash
wallctl set <file_or_dir> [--watch] [--interval N] [--quiet] [--force-refresh] [--sudo-managed-copy] [--force-managed-target]
wallctl watch <file_or_dir> [--interval N] [--quiet]
wallctl verify [--json]
wallctl doctor [--json]
wallctl restore-default [--quiet]
wallctl restore [--latest | --path <backup_path>] [--quiet]
wallctl stop-watch
wallctl version
wallctl help
```

## Managed/Jamf Notes

- `wallctl` auto-detects locked managed wallpaper policy (`com.apple.desktop`).
- If policy points to a Jamf-style override target, `wallctl set` automatically applies through that target.
- If your source format differs from the managed target extension, `wallctl` auto-converts before apply.
- A built-in stabilization second-pass is run for Jamf-default policies.
- If permissions are blocked, retry in Terminal with:

```bash
wallctl set "/absolute/path/to/image" --sudo-managed-copy --force-refresh
```

## Default Wallpaper Restore

- `wallctl restore-default` restores the cached school default wallpaper.
- On first use, `wallctl` auto-detects a default image name similar to `cchs-desktopWallpaper-default`.
- If no direct match is found, it falls back to a readable active/managed wallpaper and caches that.
- Cached default path is stored under `~/.local/state/wallctl/default/`.
- Interactive mode now shows:
  1. Restore default wallpaper
  2. Set a new wallpaper

## Exit Codes

- `0` success
- `1` usage/input error
- `2` permission/policy blocked
- `3` apply attempted but verification failed

## Repo Policy

This repository intentionally does **not** include bundled wallpaper images.
Provide your own local file path when using `wallctl`.

## Uninstall

```bash
./uninstall.sh
```
