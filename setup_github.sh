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

# Prompts for GitHub token
# Sets the Git token
read -p "Type your GitHub token: " gitToken

# Prompts for GitHub username
# Sets the Git global user username
read -p "Type your GitHub username: " gitUsername

# Prompts for GitHub e-mail
# Sets the Git global user e-mail
read -p "Type your GitHub e-mail: " gitEmail
git config --global user.email $gitEmail

# Prompts for repository name
# Constructs the full URL
read -p "Type your GitHub repository: " gitRepository
gitUrl="https://$gitToken@github.com/$gitUsername/$gitRepository"

# Executes the git remote set-url command
git remote set-url origin "$gitUrl"

# Message
echo "Remote URL updated successfully!"