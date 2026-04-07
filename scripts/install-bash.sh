#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BASHRC="$HOME/.bashrc"
SOURCE_COMMAND="source $DOTFILES_DIR/bash/prompt.sh"

log_info "Configuring bash..."

if ! grep -q "$SOURCE_COMMAND" "$BASHRC"; then
    echo -e "\n# Load custom dotfiles prompt and aliases" >> "$BASHRC"
    echo "$SOURCE_COMMAND" >> "$BASHRC"
    log_success "Custom prompt injected into .bashrc."
else
    log_success "Custom prompt already sourced in .bashrc."
fi
