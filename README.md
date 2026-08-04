# KMJ-007 dev setup


**One command:**
```bash
curl -fsSL https://raw.githubusercontent.com/KMJ-007/nvim-config/main/install.sh | bash
```

**Manual:**
```bash
# Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone and apply config
git clone https://github.com/KMJ-007/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
nix run home-manager/master -- switch --flake .#karanjanthe
```

The Git checkout remains at `~/.config/nvim` so it can be edited and updated
normally. Home Manager installs the development tools and shell configuration,
but intentionally does not replace the checkout with a Nix store symlink.

## Customization

### Add Neovim Plugins
Create/edit files in `lua/plugins/`:
```lua
return {
  "author/plugin-name",
  opts = {
    -- configuration
  },
}
```

### Add System Packages
Edit `flake.nix`, add to `buildInputs`:
```nix
buildInputs = with pkgs; [
  # existing packages...
  your-new-package
];
```

### Add Zsh Aliases/Config
Edit `flake.nix` in the `zsh` section:
```nix
shellAliases = {
  # existing aliases...
  mynew = "my-command";
};
```

## Updates

```bash
# Update packages
nix flake update
home-manager switch --flake ~/.config/nvim#karanjanthe

# Development shell (temporary environment)
nix develop
```

## Git Guidelines

**Commit:** `lua/`, `flake.nix`, `README.md`, scripts  
**Don't commit:** `flake.lock`, `lazy-lock.json`, cache dirs
