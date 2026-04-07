#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Installing zellij..."

if is_installed zellij; then
    log_success "Zellij is already installed"
else
    log_info "Installing zellij via cargo..."
    cargo install zellij
fi

mkdir -p ~/.config/zellij
ln -sf "$SCRIPT_DIR/../zellij/config.kdl" ~/.config/zellij/config.kdl

log_success "Zellij installed with configs!"
