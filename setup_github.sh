#!/bin/bash

# Function to check if Git is installed
function check_git() {
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Would you like to install it now? (y/n)"
        read -r install_git
        if [[ $install_git =~ ^[Yy]$ ]]; then
            sudo apt-get update && sudo apt-get install git -y
            check_git
        else
            echo "Git installation is recommended for this script to function."
            exit 1
        fi
    fi
}

# Checks if Git is installed
check_git

echo "https://<danmazzeu>:<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>@github.com" >> ~/.git-credentials