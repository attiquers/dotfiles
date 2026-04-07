#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Installing tmux..."

if ! is_installed tmux; then
    log_info "tmux not found, installing..."
    sudo apt-get update && sudo apt-get install -y tmux
else
    log_info "tmux is already installed"
fi

TMUX_PLUGIN_DIR="$HOME/.tmux/plugins"
TMUX_CONF_DIR="$HOME/.config/tmux/plugins"

mkdir -p "$TMUX_PLUGIN_DIR"
mkdir -p "$TMUX_CONF_DIR"

if [ ! -d "$TMUX_PLUGIN_DIR/tpm" ]; then
    log_info "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
else
    log_info "TPM already installed"
fi

if [ ! -d "$TMUX_PLUGIN_DIR/tmux-resurrect" ]; then
    log_info "Installing tmux-resurrect..."
    git clone https://github.com/tmux-plugins/tmux-resurrect "$TMUX_PLUGIN_DIR/tmux-resurrect"
else
    log_info "tmux-resurrect already installed"
fi

mkdir -p "$TMUX_CONF_DIR/catppuccin"
if [ ! -d "$TMUX_CONF_DIR/catppuccin/tmux" ]; then
    log_info "Installing catppuccin-tmux..."
    git clone https://github.com/catppuccin/tmux.git "$TMUX_CONF_DIR/catppuccin/tmux"
else
    log_info "catppuccin-tmux already installed"
fi

log_info "Creating tmux.conf..."
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/.tmux/resurrect"
mkdir -p "$SCRIPT_DIR/../tmux"
cat > "$SCRIPT_DIR/../tmux/tmux.conf" << 'EOF'
unbind r
bind r source-file ~/.tmux.conf

set -g prefix C-s

set -g mouse on

bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

set-option -g status-position top

set -g default-terminal "tmux-256color"

set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

set -g @catppuccin_status_padding_left "0"
set -g @catppuccin_status_padding_right "0"

run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"

run '~/.tmux/plugins/tpm/tpm'
EOF

ln -sf "$SCRIPT_DIR/../tmux/tmux.conf" "$HOME/.tmux.conf"
log_success "tmux.conf symlinked."

log_success "tmux installation complete!"
log_info "After starting tmux, press 'prefix + I' (Ctrl-s + I) to install plugins"
log_info "To restore sessions after restart, press 'prefix + Ctrl-s' (Ctrl-s + Ctrl-s)"
