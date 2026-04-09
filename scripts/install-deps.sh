#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Installing system dependencies..."
sudo apt update -y
sudo apt install -y alacritty wget unzip fontconfig
log_success "System dependencies installed."

if ! is_installed yazi; then
    log_info "Installing yazi..."
    YAZI_VERSION=$(curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
    curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.tar.gz" -o /tmp/yazi.tar.gz
    tar -xzf /tmp/yazi.tar.gz -C /tmp yazi
    sudo mv /tmp/yazi /usr/local/bin/
    rm /tmp/yazi.tar.gz
    log_success "yazi installed successfully."
else
    log_info "yazi is already installed."
fi
