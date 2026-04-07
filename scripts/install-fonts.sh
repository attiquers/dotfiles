#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

FONT_DIR="$HOME/.local/share/fonts"

if fc-list :family | grep -iq "JetBrainsMono Nerd Font"; then
    log_success "JetBrains Mono Nerd Font is already installed."
else
    log_info "Downloading and installing JetBrains Mono Nerd Font..."
    mkdir -p "$FONT_DIR"
    wget -qO /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -qo /tmp/JetBrainsMono.zip -d "$FONT_DIR"
    fc-cache -fv
    rm /tmp/JetBrainsMono.zip
    log_success "JetBrains Mono Nerd Font installed."
fi
