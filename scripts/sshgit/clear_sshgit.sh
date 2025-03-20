#!/bin/bash

set -euo pipefail

remove_ssh_git() {
    printf "Removing SSH and Git...\n"

    sudo systemctl stop ssh || true
    sudo apt-get purge --yes --autoremove openssh-client openssh-server git git-core

    printf "Cleaning up leftover configurations...\n"
    sudo rm -rf ~/.ssh /etc/ssh /var/lib/ssh /root/.ssh
    sudo find / -name 'git' -type d -prune -exec rm -rf {} + 2>/dev/null || true
}

install_git() {
    printf "Updating package lists...\n"
    sudo apt-get update

    printf "Installing Git...\n"
    sudo apt-get install --yes git

    printf "Verifying Git installation...\n"
    if ! command -v git &>/dev/null; then
        printf "Error: Git installation failed.\n" >&2
        return 1
    fi

    printf "Git successfully installed: %s\n" "$(git --version)"
}

main() {
    remove_ssh_git
    install_git
}

main
