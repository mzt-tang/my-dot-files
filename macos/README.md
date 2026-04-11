# macOS Dev Setup

Terminal-centric dev environment built around Ghostty + Zellij + Starship.

## Tools

### Terminal & Shell

- **[Ghostty](https://ghostty.org)** - GPU-rendered terminal emulator. Supports Kitty image protocol. Config: `.config/ghostty/config` (Solarized Light theme, no window decoration, font 14, option-as-alt).
- **[Zellij](https://zellij.dev)** - Terminal multiplexer (tmux alternative). Config: `.config/zellij/config.kdl` (catppuccin-latte theme, vim-style hjkl keybinds, clear-defaults, tmux-compat layer). Custom `agent` layout splits into Terminal + Claude pane.
- **[Starship](https://starship.rs)** - Cross-shell prompt. Using default config, no customization.
- **[Karabiner-Elements](https://karabiner-elements.pqrs.org)** - Keyboard remapping. Caps Lock remapped to Meh key (Ctrl+Option+Shift). Rule: `.config/karabiner/meh-key.json`.

### CLI Replacements

- **[eza](https://github.com/eza-community/eza)** - `ls` replacement with icons and git status. Aliased as `ls`.
- **[bat](https://github.com/sharkdp/bat)** - `cat` replacement with syntax highlighting. Aliased as `cat`.
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - `cd` replacement with frecency-based directory jumping. Aliased as `cd`.
- **[yazi](https://yazi-rs.github.io)** - Terminal file manager with previews. Config: `.config/yazi/yazi.toml` (show hidden, natural sort, dirs first).

### Dev Tooling

- **[mise](https://mise.jdx.dev)** - Polyglot version manager (nvm/rbenv/asdf replacement). Currently: Node 22, Ruby 3.3.7, Yarn 1.22.22.
- **[GitHub CLI (gh)](https://cli.github.com)** - GitHub from the terminal. Config: `.config/gh/config.yml` (https protocol, `co` alias for `pr checkout`).
- **[Git](https://git-scm.com)** - Config: `.gitconfig`. Auto-tracks remote branches on push, rebases on pull. Aliases: `cleanup` (prune gone branches), `co` (checkout), `st` (status).

### Fun

- **[fastfetch](https://github.com/fastfetch-cli/fastfetch)** - System info display on terminal open. Custom `fastfetch-random` script (`.local/bin/fastfetch-random`) picks a random image from `~/Pictures/fastfetch/` and renders it via Kitty protocol.

## Install

```bash
brew install starship eza bat zoxide fastfetch yazi mise gh git
```

Ghostty and Karabiner-Elements are downloaded separately from their websites.

## Setup

```bash
# Shell
cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile

# App configs
cp -r .config/ghostty ~/.config/
cp -r .config/zellij ~/.config/
cp -r .config/gh ~/.config/
cp -r .config/yazi ~/.config/

# Karabiner - import meh-key.json rule via Karabiner preferences UI

# fastfetch
mkdir -p ~/.local/bin ~/Pictures/fastfetch
cp .local/bin/fastfetch-random ~/.local/bin/
chmod +x ~/.local/bin/fastfetch-random

# Git
cp .gitconfig ~/.gitconfig
# Update email for personal use

# Mise
mise install node@22 ruby@3.3.7 yarn@1.22.22
```

## Notes

- Zellij blocks Kitty image protocol passthrough, so fastfetch falls back to chafa inside Zellij sessions
- The `agent` zellij layout has a hardcoded cwd - update for your project
- `.gitconfig` email is set to `CHANGEME`
