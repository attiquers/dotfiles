#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define directories
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions for logging
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

log_info "Starting dotfiles installation..."

# ==========================================
# 1. Install System Dependencies
# ==========================================
log_info "Updating package lists and installing dependencies..."
sudo apt update -y
sudo apt install -y alacritty wget unzip fontconfig

# ==========================================
# 2. Install JetBrains Mono Nerd Font
# ==========================================
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
    log_success "Font installed successfully."
fi

# ==========================================
# 3. Create Symlinks (The Scalable Part)
# ==========================================
log_info "Linking configuration files..."

# Alacritty
mkdir -p "$CONFIG_DIR/alacritty"
ln -sf "$DOTFILES_DIR/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
log_success "Symlinked Alacritty config."

# Zellij
mkdir -p "$CONFIG_DIR/zellij"
ln -sf "$DOTFILES_DIR/zellij/config.kdl" "$CONFIG_DIR/zellij/config.kdl"
log_success "Symlinked Zellij config."

# ==========================================
# 4. Inject into Bashrc
# ==========================================
log_info "Configuring bash..."

BASHRC="$HOME/.bashrc"
SOURCE_COMMAND="source $DOTFILES_DIR/bash/prompt.sh"

# Only add the source command if it doesn't already exist
if ! grep -q "$SOURCE_COMMAND" "$BASHRC"; then
    echo -e "\n# Load custom dotfiles prompt and aliases" >> "$BASHRC"
    echo "$SOURCE_COMMAND" >> "$BASHRC"
    log_success "Injected custom prompt into .bashrc."
else
    log_success "Custom prompt already sourced in .bashrc."
fi

# ==========================================
# 5. Wrap Up
# ==========================================
log_info "Installation complete! Please restart your terminal or run: source ~/.bashrc"
