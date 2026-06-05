#!/usr/bin/env bash
# Bootstrap a fresh Linux or macOS machine.
# Usage: curl -fsSL https://raw.githubusercontent.com/mzt-tang/my-dot-files/main/bootstrap/bootstrap.sh | bash
set -e

REPO="https://github.com/mzt-tang/my-dot-files.git"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── helpers ───────────────────────────────────────────────────────────────────
install_extras_linux() {
    # mise (dev tools version manager)
    if ! command -v mise &>/dev/null; then
        echo "Installing mise..."
        curl https://mise.run | sh
    fi

    # starship
    if ! command -v starship &>/dev/null; then
        echo "Installing starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
    fi

    # zoxide
    if ! command -v zoxide &>/dev/null; then
        echo "Installing zoxide..."
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi

    # zellij
    if ! command -v zellij &>/dev/null; then
        echo "Installing zellij..."
        ZELLIJ_VERSION=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
        curl -fsSL "https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz" \
            | tar -xz -C "$BIN_DIR"
    fi

    # eza (modern ls)
    if ! command -v eza &>/dev/null; then
        echo "Installing eza..."
        EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
        curl -fsSL "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_x86_64-unknown-linux-musl.tar.gz" \
            | tar -xz -C "$BIN_DIR"
    fi
}

set_default_shell() {
    local shell_path
    shell_path="$(command -v fish)"
    if [ -z "$shell_path" ]; then
        echo "fish not found in PATH, skipping default shell change"
        return
    fi
    # Add to /etc/shells if not already there
    if ! grep -qxF "$shell_path" /etc/shells; then
        echo "$shell_path" | sudo tee -a /etc/shells
    fi
    if [ "$SHELL" != "$shell_path" ]; then
        echo "Setting default shell to fish..."
        chsh -s "$shell_path"
    fi
}

# ── chezmoi ───────────────────────────────────────────────────────────────────
if ! command -v chezmoi &>/dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$BIN_DIR"
fi

# ── OS packages ───────────────────────────────────────────────────────────────
if command -v apt-get &>/dev/null; then
    PACKAGES=$(grep -v '^\s*#' "$SCRIPT_DIR/../packages/apt-minimal.txt" | grep -v '^\s*$' | tr '\n' ' ')
    echo "Installing apt packages..."
    sudo apt-get update -qq
    sudo apt-get install -y $PACKAGES
    install_extras_linux
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    echo "Installing Homebrew packages..."
    brew bundle --file "$SCRIPT_DIR/../packages/Brewfile"
fi

# ── dotfiles ──────────────────────────────────────────────────────────────────
echo "Applying dotfiles..."
chezmoi init --apply "$REPO"

# ── default shell ─────────────────────────────────────────────────────────────
set_default_shell

echo ""
echo "Done. Log out and back in (or run: exec fish) to start using fish."
