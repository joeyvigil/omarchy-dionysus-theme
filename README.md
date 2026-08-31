# dionysus — an Omarchy theme

A dark Omarchy theme derived from [pewdiepie-archdaemon/dionysus](https://github.com/pewdiepie-archdaemon/dionysus),
a Hyprland rice for Arch Linux. The rice is a One Dark / Nord hybrid keyed on a
neon pale cyan (`#9cdef2`), and this theme carries that palette into every
surface Omarchy themes: terminal, bar, menus, lock screen, btop, Helix, Neovim,
and VS Code.

## Install

The theme lives in `Projects/`, so installing means linking it into Omarchy's
user theme directory:

```sh
ln -s ~/Projects/dionysus-omarchy-theme ~/.config/omarchy/themes/dionysus
omarchy theme set dionysus
```

A symlink is the recommended install. Omarchy treats a symlinked theme as one
you wrote yourself and stages every file in it. A theme cloned by
`omarchy theme install <git-url>` is held to a narrower allowlist that drops
`.lua` and `vscode.json`, so `neovim.lua` and `vscode.json` below would be
skipped and Omarchy would generate its own from `colors.toml` instead.

To copy rather than link:

```sh
cp -r ~/Projects/dionysus-omarchy-theme ~/.config/omarchy/themes/dionysus
omarchy theme set dionysus
```


