# wallctl

Portable macOS terminal app for setting desktop wallpaper from either an image file path or a directory.

## Install

```bash
chmod +x wallctl install.sh uninstall.sh
./install.sh
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
