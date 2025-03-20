#!/bin/bash

set -euo pipefail

install_vim() {
    if ! command -v vim >/dev/null 2>&1; then
        printf "Installing Vim...\n"
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y vim
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y vim-enhanced
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y vim-enhanced
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm vim
        elif command -v zypper >/dev/null 2>&1; then
            sudo zypper install -y vim
        else
            printf "Package manager not found. Install Vim manually.\n" >&2
            return 1
        fi
    else
        printf "Vim is already installed.\n"
    fi
}

install_neovim() {
    if ! command -v nvim >/dev/null 2>&1; then
        printf "Installing Neovim...\n"
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y neovim
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y neovim
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y neovim
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm neovim
        elif command -v zypper >/dev/null 2>&1; then
            sudo zypper install -y neovim
        else
            printf "Package manager not found. Install Neovim manually.\n" >&2
            return 1
        fi
    else
        printf "Neovim is already installed.\n"
    fi
}

main() {
    install_vim
    install_neovim
    printf "Vim and Neovim are ready to rock! 🤘\n"
}

main
