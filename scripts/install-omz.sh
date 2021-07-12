#!/usr/bin/env bash

ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

## Initial cleanup.
rm -Rf "${HOME}/.oh-my-zsh"

## Download OMZ installer, set to execute, and install.
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/omz.sh 
chmod +x /tmp/omz.sh
sh /tmp/omz.sh --unattended

## Clone plugins for autosuggestions, history search, syntax highlighting, spaceship theme.
git clone "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone "https://github.com/zsh-users/zsh-history-substring-search" "${ZSH_CUSTOM}/plugins/zsh-history-substring-search"
git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
git clone "https://github.com/denysdovhan/spaceship-prompt.git" "${ZSH_CUSTOM}/themes/spaceship-prompt" --depth=1
ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

## Cleanup
rm /tmp/omz.sh