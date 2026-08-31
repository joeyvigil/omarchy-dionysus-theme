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

## Contents

| File | What it is |
| --- | --- |
| `colors.toml` | The palette. Everything else Omarchy shows is generated from it. |
| `backgrounds/1-dionysus.png` | Desktop wallpaper (see [Wallpaper licensing](#wallpaper-licensing)). |
| `neovim.lua` | Neovim colorscheme plugin spec. |
| `icons.theme` | GTK icon theme name. |
| `vscode.json` | VS Code / VSCodium / Cursor extension + theme name. |
| `fetch-backgrounds.sh` | Downloads the two backgrounds this repo does not host. |

## The palette

`colors.toml` uses exactly the key set Omarchy's stock themes use — the same 26
keys, in the same order, as `/usr/share/omarchy/themes/nord/colors.toml`.

| Key | Value | Where it comes from in the rice |
| --- | --- | --- |
| `accent` | `#9cdef2` | The signature colour, 25 uses across the rice. Alacritty foreground, Hyprland active border, cursor text, eww headers. |
| `background` | `#282c34` | Alacritty background and the Waybar window background. One Dark's base. |
| `dark_background` | `#1e2127` | Derived (see [Judgment calls](#judgment-calls)). |
| `darker_background` | `#191919` | Rofi window background; the `rgba(25,25,25,…)` gradients throughout eww. |
| `lighter_background` | `#3b4252` | Waybar bar background and tooltip background. Nord `nord1`. |
| `selection` | `#3e4451` | Alacritty selection background, verbatim. |
| `muted` | `#4c566a` | Waybar hover background. Nord `nord3`. Also serves as ANSI bright black. |
| `foreground` | `#c4ecf0` | eww `.power-label2` — the rice's pale cyan (see [Judgment calls](#judgment-calls)). |
| `light_foreground` | `#88c0d0` | eww borders and panel headers. Nord frost. |
| `dark_foreground` | `#828997` | Alacritty ANSI white — the rice's dim grey text. |
| `bright_foreground` | `#eceff4` | eww `.welcome-sub`. Nord `nord6`. Also the cursor. |
| `red` | `#e06c75` | Alacritty ANSI red. |
| `bright_red` | `#ff6c6b` | eww `.red_1` / `.red_2` — the rice's brighter red. |
| `yellow` | `#e5c07b` | Alacritty ANSI yellow; Waybar profile module. |
| `orange` | `#fab387` | The rice's highlight accent, 22 uses. Active workspace, clock, rofi entries. |
| `green` | `#98c379` | eww `.green_2` (see [Judgment calls](#judgment-calls)). |
| `bright_green` | `#a3be8c` | eww battery indicator. Nord aurora green. |
| `cyan` | `#56b6c2` | The rice's teal, 22 uses. Waybar side borders, workspace buttons, tooltips. |
| `bright_cyan` | `#9cdef2` | The signature neon, again. |
| `blue` | `#61afef` | The rice's structural blue, 17 uses. Borders throughout eww, rofi, and Waybar. |
| `magenta` | `#c678dd` | Alacritty ANSI magenta. |
| `brown` | `#7d5a44` | Derived (see [Judgment calls](#judgment-calls)). |

`bright_yellow`, `bright_blue`, and `bright_magenta` repeat their base colours,
which is what the stock `nord` and `catppuccin` themes do — the rice has no
second tone for any of them.

## Judgment calls

**Green and cyan.** In the rice, ANSI `green` and ANSI `cyan` are *both*
`#9cdef2`. That is deliberate there — it makes the terminal read as a single
sheet of neon — but it breaks any program that distinguishes the two, which is
most of them: `ls --color`, `git status`, and every diff would render additions
and paths in the same colour. This theme gives `green` a real green, `#98c379`,
taken from eww's `.green_2` class so it is still a rice colour rather than an
import. The neon is preserved as `accent` and as `bright_cyan`.

**Where the neon lives.** `#9cdef2` is the rice's Alacritty *foreground*, so
the obvious move is `foreground = "#9cdef2"`. Two things argue against it.
Omarchy's Alacritty template sets ANSI white from `foreground`, so making them
equal recreates exactly the collision the previous paragraph fixes, just in a
different pair. And `accent` drives Hyprland's active border, bar highlights,
menu selections, and the lock screen — if body text is the accent colour, the
accent stops accenting anything.

So `foreground` is `#c4ecf0`, the rice's own pale cyan from eww's
`.power-label2`. It keeps the cyan cast on all text, is brighter than the neon
so the neon still reads as a highlight against it, and leaves `#9cdef2` free to
do its real job as `accent` and `bright_cyan`. Both cyans of the rice get a
home: `#56b6c2` is ANSI cyan, `#9cdef2` is ANSI bright cyan.

**Two derived values.** The rice has no colour for `dark_background` — its
darker tones are `#191919` (used here as `darker_background`) and the neutral
`#1e1e1e`, neither of which sits correctly between `#191919` and `#282c34`. It
has no brown at all. Both are therefore computed rather than picked, as a plain
linear blend toward black: `dark_background` is `background` at 25% black
(`#1e2127`), and `brown` is `orange` at 50% black (`#7d5a44`). Omarchy ships no
colour-mixing helper of its own and does not fill in omitted keys, so every one
of the 26 keys is written out explicitly.

**Neovim and VS Code.** Neither the rice nor Omarchy ships a dionysus
colorscheme for these, so both files point at the closest published theme —
`navarasu/onedark.nvim` with `style = "cool"`, and One Dark Pro. Both are One
Dark, which is the rice's base, but neither has the neon cyan.

If you would rather have an exact palette match than a real published theme,
delete the file: with `neovim.lua` absent Omarchy generates one from
`colors.toml` using `aether.nvim`, and with `vscode.json` absent it generates a
full VS Code colour theme from `colors.toml` and installs it as a local
extension. Those are built from the 26 keys above, so they match this palette
precisely. The files are here because that is the shape the stock themes use.

## Contrast

`foreground` `#c4ecf0` on `background` `#282c34` is **11.07:1** — above WCAG
AAA for body text (7:1), and better than stock `nord` (9.25:1). No adjustment
was needed.

| Sample | Ratio on `#282c34` |
| --- | --- |
| `bright_foreground` `#eceff4` | 12.15:1 |
| `foreground` `#c4ecf0` | 11.07:1 |
| `accent` `#9cdef2` | 9.43:1 |
| `light_foreground` `#88c0d0` | 7.00:1 |
| `dark_foreground` `#828997` | 3.98:1 |
| dimmest ANSI colour (`red` `#e06c75`) | 4.38:1 |

`dark_foreground` and `red` land below 4.5:1, which is normal for these roles —
`dark_foreground` is deliberately recessive secondary text, and stock `nord`'s
equivalents are 2.49:1 and 3.05:1. Every value here is more legible than nord's.
The background ladder is strictly monotonic:
`#191919` → `#1e2127` → `#282c34` → `#3b4252` → `#3e4451` → `#4c566a`.

## Backgrounds

Five, cycled with `omarchy theme bg next`. All were chosen or checked against the
palette's own signature — mean `R87 G115 B146`, standard deviation 32: blue
dominant, mid-dark, low contrast from atmospheric haze.

| File | Size | What it is |
| --- | --- | --- |
| `1-dionysus.png` | 2008×1112 | The rice's own wallpaper, salvaged (below). |
| `2-street-power-lines.png` | 2560×1280 | Dusk street under power lines. The closest match in mood. |
| `3-mist-spheres.jpg` † | 2880×1440 | Spherical structures in cold hillside fog. |
| `4-tower-blocks.jpg` † | 2880×1440 | Tower blocks over a low landscape at blue hour. |
| `5-watchtower.png` | 2560×1600 | A watchtower above forest under a cold sky. |

Numbers 2–5 come from [dharmx/walls](https://github.com/dharmx/walls).

† **Not included in this repository.** 3 and 4 are Simon Stålenhag paintings, so
this repo does not host them. Run `./fetch-backgrounds.sh` once after cloning to
download them from the collection they came from, then re-apply the theme. The
theme works fine without them — you simply cycle three backgrounds instead of
five.

### The dionysus wallpaper

`backgrounds/1-dionysus.png` is a **salvage**, not the rice's original wallpaper.

Upstream's `dotfiles/hypr/wallpapers/bg_wallpaper.png` — the file `hyprpaper.conf`
actually loads — is not a wallpaper at all. It is a 2560×1440 desktop screenshot:
a cyan Hyprland window border at x=26–29 and x=2531–2535, a black panel filling
x=31–517, and the photograph only occupying the region to its right. Setting it
as a wallpaper gives you a black bar down the left edge and a cyan rectangle
around everything.

This theme ships the photo region cropped out of it — `x 523–2530, y 160–1271`,
giving **2008×1112** at an aspect of 1.806. That is a screenshot of the image as
it was displayed inside a window, so it has been scaled and re-encoded at least
once; it is softer than a true original would be, and it upscales slightly on a
2560×1440 display. The original file it was captured from is not in the repo.

**Provenance is unclear and redistribution is not advised.** The upstream repo
publishes no license, and the photograph itself — a winter view of Soviet-era
panel blocks behind power-station cooling towers — is by an unidentified
photographer who is almost certainly not the rice's author. Personal desktop use
is ordinary and fine. Publishing a fork with this file is not: delete
`backgrounds/1-dionysus.png` and substitute your own, or ship an empty
`backgrounds/` and let users add their own with `omarchy theme bg install`.

### The other four

`2-street-power-lines.png` and `5-watchtower.png` are third-party images whose
authors the source collection does not record. They are bundled here; if you are
one of those authors, see the removal note in Credits.

`3-mist-spheres.jpg` and `4-tower-blocks.jpg` are deliberately absent, because
they are the work of a named, living artist who sells them. Fetching an image
for your own desktop is ordinary personal use; rehosting it is not. That is the
line this repository draws, and `fetch-backgrounds.sh` exists so drawing it
costs you nothing.

The palette itself is a set of colour values read out of the rice's config
files and is not covered by that concern.

## Credits

Palette derived from [pewdiepie-archdaemon/dionysus](https://github.com/pewdiepie-archdaemon/dionysus)
by pewdiepie-archdaemon. Structured for [Omarchy](https://omarchy.org).

### Background artwork

None of the backgrounds are the work of this theme's author, and none are
offered under any license by it.

- `3-mist-spheres.jpg` and `4-tower-blocks.jpg` are paintings by
  **[Simon Stålenhag](https://simonstalenhag.se/)**, and are *not* in this
  repository for that reason — `fetch-backgrounds.sh` pulls them from the
  collection they were taken from. All rights remain his. Please buy his books.
- `2-street-power-lines.png` and `5-watchtower.png` are from
  [dharmx/walls](https://github.com/dharmx/walls), which does not record their
  authors. Rights remain with whoever made them.
- `1-dionysus.png` is cropped from a screenshot in the upstream dionysus repo.
  The photographer is unidentified.

If you hold rights to any image here and want it removed, open an issue or email
the repository owner and it will be deleted promptly — no argument, no delay.

Prefer to install the theme without any of it? Delete `backgrounds/` before
running `omarchy theme set`; the theme works fine with an empty background
directory, and you can add your own with `omarchy theme bg install`.
