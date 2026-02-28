#!/bin/bash
set -e

echo "Installing tools..."
brew install neovim tmux yazi ripgrep fd fzf
pip install pynvim ruff black debugpy
npm install -g pyright

echo "Linking configs..."
mkdir -p ~/.config
ln -sf "$(pwd)/nvim" ~/.config/nvim
ln -sf "$(pwd)/tmux.conf" ~/.tmux.conf
mkdir -p ~/.config/yazi
ln -sf "$(pwd)/yazi/keymap.toml" ~/.config/yazi/keymap.toml

echo "Setting EDITOR..."
if ! grep -q "export EDITOR='nvim'" ~/.zshrc 2>/dev/null; then
    echo "export EDITOR='nvim'" >> ~/.zshrc
    echo "export VISUAL='nvim'" >> ~/.zshrc
fi

echo "Done! Open nvim to auto-install plugins."
