#!/bin/bash

set -e

echo "🚀 Setting up Karan's Development Environment"

# Check if Nix is installed
if ! command -v nix &> /dev/null; then
    echo "📦 Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Enable flakes
echo "⚙️ Configuring Nix..."
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Clone this repository if not already present
if [ ! -d "~/.config/nvim/.git" ]; then
    echo "📥 Cloning configuration..."
    git clone <YOUR_REPO_URL> ~/.config/nvim-temp
    mv ~/.config/nvim-temp/* ~/.config/nvim/
    rm -rf ~/.config/nvim-temp
fi

cd ~/.config/nvim

echo "🏠 Setting up Home Manager..."
# Install Home Manager standalone
nix run home-manager/master -- switch --flake .#karanjanthe

echo "🎉 Setup complete!"
echo ""
echo "To activate the development shell, run:"
echo "  cd ~/.config/nvim && nix develop"
echo ""
echo "To update your configuration:"
echo "  home-manager switch --flake ~/.config/nvim#karanjanthe"
echo ""
echo "Restart your terminal to apply zsh changes."