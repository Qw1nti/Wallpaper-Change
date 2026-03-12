# wallctl

Portable macOS terminal app for setting desktop wallpaper from either an image file path or a directory.

## Features

- Single CLI: `wallctl`
- Supports `set`, `verify`, `watch`, `restore`, `doctor`, `stop-watch`, `version`
- Accepts file or directory input
- Deterministic directory selection:
  1. extensions: `jpg jpeg png heic webp tif tiff`
  2. newest by mtime
  3. lexical tie-break
- Auto-detects managed wallpaper policy (`com.apple.desktop`) and adapts when possible
- Optional self-heal mode (`watch`) for policy drift

## Install

From this repo:

```bash
chmod +x wallctl install.sh uninstall.sh scripts/*.sh
./install.sh
```

## Quick Start

One-command interactive mode:

```bash
wallctl
```

It will prompt for an image file/directory path and do the full apply flow automatically.

Set wallpaper from a file:

```bash
wallctl set "/absolute/path/to/image.jpg"
```

Force a hard wallpaper refresh (cache + agents):

```bash
wallctl set "/absolute/path/to/image.jpg" --force-refresh
```

Set wallpaper from a directory (auto-select newest valid image):

```bash
wallctl set "/absolute/path/to/images-directory"
```

Verify status:

```bash
wallctl verify
```

Doctor diagnostics:

```bash
wallctl doctor
```

JSON output:

```bash
wallctl verify --json
wallctl doctor --json
```

## Watch mode

Foreground:

```bash
wallctl watch "/absolute/path/to/image-or-dir" --interval 15
```

Background from `set`:

```bash
wallctl set "/absolute/path/to/image-or-dir" --watch --interval 15
```

Stop watcher:

```bash
wallctl stop-watch
```

## Managed-policy helper

If `wallctl doctor` reports managed path not writable, retry with sudo-managed copy:

```bash
wallctl set "/absolute/path/to/image.jpg" --sudo-managed-copy --force-refresh
```

If your Mac is managed and you want to always write/apply through the managed override path:

```bash
wallctl set "/absolute/path/to/image.jpg" --force-managed-target --sudo-managed-copy --force-refresh
```

Jamf default detection is automatic: if a locked managed override path looks like a JamfConnect wallpaper target, `wallctl set` will automatically apply through that managed path.
If the managed target extension differs from your source (for example `.webp` source to `.jpg` managed target), `wallctl` automatically converts to the target format before applying.
For managed/Jamf paths, `wallctl` also performs an internal post-apply stabilization pass (timed re-apply) so you typically only need to run once.
For Jamf-default policies specifically, `wallctl` now performs an automatic delayed second managed apply pass in the same command (to replace manual “run it twice” behavior).

## Restore

Restore latest backup:

```bash
wallctl restore --latest
```

Restore specific backup:

```bash
wallctl restore --path "/path/to/backup.jpg"
```

## Compatibility wrappers

Legacy scripts in `scripts/` are still available and now delegate to `wallctl`:

- `scripts/set-managed-wallpaper.sh`
- `scripts/verify-managed-wallpaper.sh`
- `scripts/watch-managed-wallpaper.sh`
- `scripts/restore-original-managed-wallpaper.sh`

## Exit codes

- `0`: success
- `1`: usage/input error
- `2`: permission/policy blocked
- `3`: apply attempted but verification failed

## Uninstall

```bash
./uninstall.sh
```
