# 🚀 Karan's Development Environment

A complete development setup using **LazyVim** and **Nix** for easy replication across machines.

## ✨ What's Included

### 🔧 Development Tools
- **Neovim** with LazyVim configuration
- **Zsh** with Oh My Zsh and modern tools
- **Git** configuration
- Language servers and formatters
- Modern shell utilities (bat, eza, ripgrep, fzf, zoxide)

### 🎨 Neovim Features
- **Catppuccin** theme
- **LSP** support for multiple languages
- **Telescope** fuzzy finder with hidden files
- **Neo-tree** file explorer with hidden files
- **Terminal** integration with ToggleTerm
- **Git** integration with gitsigns
- Custom keymaps and options

## 🏃‍♂️ Quick Setup (New Machine)

### Option 1: One-Command Setup
```bash
curl -fsSL https://raw.githubusercontent.com/KMJ-007/nvim-config/main/install.sh | bash
```

### Option 2: Manual Setup
1. **Install Nix:**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. **Clone this repo:**
   ```bash
   git clone https://github.com/KMJ-007/nvim-config.git ~/.config/nvim
   cd ~/.config/nvim
   ```

3. **Apply configuration:**
   ```bash
   nix run home-manager/master -- switch --flake .#karanjanthe
   ```

4. **Restart your terminal**

## 🔄 Daily Usage

### Development Shell
Enter a development environment with all tools:
```bash
cd ~/.config/nvim
nix develop
```

### Update Configuration
```bash
home-manager switch --flake ~/.config/nvim#karanjanthe
```

### Update Packages
```bash
nix flake update
home-manager switch --flake ~/.config/nvim#karanjanthe
```

## ⚙️ What to Update vs. What NOT to Update

### ✅ Safe to Update (Commit to Git)
- `lua/` directory - Your Neovim configuration
- `flake.nix` - Package and configuration changes
- `README.md` - Documentation updates
- `.gitignore` - Ignore patterns
- `install.sh` - Setup script improvements

### ❌ DO NOT Commit to Git
- `flake.lock` - Pin this for reproducibility, only update intentionally
- `lazy-lock.json` - LazyVim plugin lock file
- `.lazy/` - LazyVim cache directory
- `result*` - Nix build artifacts

### 🔄 Update Strategies

**Conservative (Recommended):**
- Only update `flake.lock` when you need new features
- Test updates in the development shell first

**Bleeding Edge:**
- Update `flake.lock` regularly with `nix flake update`
- Stay on latest packages

## 🎯 Key Features

### Neovim Configuration
- **Hidden Files**: `.env`, `.github`, etc. visible in file explorer and finder
- **Catppuccin Theme**: Beautiful dark theme
- **Smart Defaults**: Relative line numbers, proper indentation, clipboard integration
- **Terminal Integration**: Floating terminal with `Ctrl+\`
- **Git Integration**: Visual git status and blame

### Shell Configuration
- **Modern Aliases**: `ll`, `ls`, `cat`, `find`, `grep` use modern tools
- **Auto-suggestions**: Zsh autosuggestions and syntax highlighting
- **Directory Navigation**: Zoxide for smart `cd` replacement
- **Fuzzy Finding**: FZF integration for command history and file finding

---

*Happy coding! 🎉*
