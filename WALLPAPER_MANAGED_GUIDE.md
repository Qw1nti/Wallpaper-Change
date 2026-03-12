# Managed Wallpaper Notes

This Mac is managed and enforces desktop settings through a policy payload (`com.apple.desktop`) with a locked override path.

Use `wallctl` for all wallpaper operations.

## Quick commands

```bash
zsh wallctl set "/absolute/path/to/image-or-directory"
zsh wallctl verify
zsh wallctl doctor
```

If policy keeps changing it back:

```bash
zsh wallctl set "/absolute/path/to/image-or-directory" --watch --interval 15
zsh wallctl stop-watch
```

## Restore old wallpaper backup from this workspace

```bash
zsh wallctl restore --path "/Users/ivillatoro27471/Documents/VsCodeStuff/Stuff/RandomStuff/cchs-desktopWallpaper-default.backup.jpg"
```

See full docs in `README.md`.
