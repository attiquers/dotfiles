#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Installing alacritty..."

if is_installed alacritty; then
    log_success "Alacritty is already installed"
else
    log_info "Installing alacritty via cargo..."
    cargo install alacritty
fi

mkdir -p ~/.config/alacritty
ln -sf "$SCRIPT_DIR/../alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

log_success "Alacritty installed with configs!"
