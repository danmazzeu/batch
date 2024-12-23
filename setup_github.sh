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

# Clear Credential Cache (optional, but recommended)
git credential-cache --erase

# Prompt for GitHub username
# Sets the Git global user username
read -p "Type your GitHub username: " gitUsername
git config --global user.name "$gitUsername"

# Prompt for GitHub e-mail
# Sets the Git global user e-mail
read -p "Type your GitHub e-mail: " gitEmail
git config --global user.email "$gitEmail"

# Prompt for repository name
# Constructs the full URL (without token)
read -p "Type your GitHub repository: " gitRepository
gitUrl="https://github.com/$gitUsername/$gitRepository"

# Read GitHub personal access token securely (avoiding script storage)
echo "Enter your GitHub personal access token (it won't be shown):"
read -r -s gitToken

# Setup Main Branch (assuming the main branch is named 'main')
git push origin main -u

# Set Git remote URL using the token (not stored in script)
git remote set-url origin "https://$gitToken@$gitUrl"

# Message
echo "Remote URL updated successfully!"