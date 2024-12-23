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

# Set the username and password for GitHub
GITHUB_USERNAME="danmazzeu"
GITHUB_PASSWORD="%448600%55Dd"

# Set the repository name
REPO_NAME="batch"

# Set the remote URL
REMOTE_URL="git@github.com:${GITHUB_USERNAME}/${REPO_NAME}.git"


echo "Repository setup to GitHub successfully!"