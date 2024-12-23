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

read -p "Digite seu token: " -s token

read -p "Digite seu usuário: "  user

read -p "Digite seu repositorio: "  repo


# Construct secure Git remote URL
git_remote_url="https://${token}@github.com/${user}/${repo}"

git push --set-upstream origin main
git remote add origin "$git_remote_url"
git push origin

echo "Successfully pushed to remote repository."