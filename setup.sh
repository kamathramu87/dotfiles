#!/bin/bash
set -e

echo "Installing tools..."
brew install neovim tmux yazi ripgrep fd fzf lazygit
pip install pynvim ruff black debugpy
npm install -g pyright

echo "Linking configs..."
mkdir -p ~/.config

ln -sf "$(pwd)/nvim" ~/.config/nvim
ln -sf "$(pwd)/tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/yazi" ~/.config/yazi
ln -sf "$(pwd)/zshrc" ~/.zshrc
ln -sf "$(pwd)/p10k.zsh" ~/.p10k.zsh
ln -sf "$(pwd)/k8s-fzf.sh" ~/dotfiles/k8s-fzf.sh

echo "Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Installing powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k 2>/dev/null || true

echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 2>/dev/null || true

echo "Done! Open nvim to auto-install plugins. Restart terminal for zsh changes."
