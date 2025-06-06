#!/bin/bash

ZSHRC="/home/vscode/.zshrc"

# Set theme to robbyrussell
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="robbyrussell"/' "$ZSHRC"

# Ensure plugins are set
sed -i 's/^plugins=(.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"

# Add font preview note
echo '# Using CaskaydiaMono Nerd Font — make sure VS Code is configured' >> "$ZSHRC"

# Add helpful aliases
echo 'alias ll="ls -lah"' >> "$ZSHRC"

# Set Oh My Zsh update behavior
echo '# Oh My Zsh Update Preferences' >> "$ZSHRC"
echo 'DISABLE_AUTO_UPDATE=false' >> "$ZSHRC"
echo 'DISABLE_UPDATE_PROMPT=false' >> "$ZSHRC"
# Set desired Oh My Zsh plugins
sed -i '/^plugins=/c\plugins=(\
  git \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  z \
  extract \
  sudo \
  history-substring-search \
  colored-man-pages \
  alias-finder \
  docker \
  command-not-found \
)' "$ZSHRC"

echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> "$ZSHRC"

# Fix ownership in case it's root
chown vscode:vscode "$ZSHRC"
