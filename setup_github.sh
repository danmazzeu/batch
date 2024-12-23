#!/bin/bash

# Check if a Git repository is already initialized
if ! git init -q >/dev/null 2>&1; then
  echo "Initializing a new Git repository..."
  git init
fi

# Prompt the user for the remote repository name
read -p "Enter your username: " username

# Prompt the user for the remote repository name
read -p "Enter the remote repository: " repository

# Add the remote repository using double quotes for proper variable expansion
git remote add "$repository" "https://github.com/$username/$repository"

# Message
echo "Repository '$repository' added successfully."