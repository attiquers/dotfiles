#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/common.sh"

print_banner() {
    echo -e "${CYAN}"
    echo "  ╔═══════════════════════════════════════╗"
    echo "  ║              DOTFILES                ║"
    echo "  ╚═══════════════════════════════════════╝"
    echo -e "${NC}"
}

print_menu() {
    echo -e "${GREEN}Setup:${NC}"
    echo "  1) Install dependencies"
    echo "  2) Install fonts"
    echo "  3) Install bash (and configs)"
    echo ""
    echo -e "${GREEN}Tools:${NC}"
    echo "  4) Install alacritty (and configs)"
    echo "  5) Install zellij (and configs)"
    echo ""
    echo -e "${GREEN}Other:${NC}"
    echo "  6) Install ALL"
    echo "  0) Quit"
    echo ""
}

run_script() {
    local script="$SCRIPT_DIR/scripts/$1"
    if [[ -f "$script" ]]; then
        bash "$script"
    else
        log_error "Script not found: $script"
        return 1
    fi
}

while true; do
    print_banner
    print_menu

    read -p "Select an option: " choice

    case "$choice" in
    1) run_script "install-deps.sh" ;;
    2) run_script "install-fonts.sh" ;;
    3) run_script "install-bash.sh" ;;
    4) run_script "install-alacritty.sh" ;;
    5) run_script "install-zellij.sh" ;;
    6)
        log_info "Running full installation..."
        run_script "install-deps.sh"
        run_script "install-fonts.sh"
        run_script "install-bash.sh"
        run_script "install-alacritty.sh"
        run_script "install-zellij.sh"
        log_success "Installation complete! Restart your terminal or run: source ~/.bashrc"
        ;;
    0) echo "Goodbye!" && break ;;
    *) log_error "Invalid option" ;;
    esac
done
