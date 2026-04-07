#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Installing system dependencies..."
sudo apt update -y
sudo apt install -y alacritty wget unzip fontconfig
log_success "System dependencies installed."
