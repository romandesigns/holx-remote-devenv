#!/bin/bash

ZSHRC="/home/vscode/.zshrc"

# Set theme to robbyrussell
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="robbyrussell"/' "$ZSHRC"

# Ensure plugins are set
sed -i 's/^plugins=(.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"

# Add font preview if needed
echo '# Using CaskaydiaMono Nerd Font — make sure VS Code is configured' >> "$ZSHRC"

# Optional: add helpful aliases
echo 'alias ll="ls -lah"' >> "$ZSHRC"

# Fix ownership in case it's root
chown vscode:vscode "$ZSHRC"
