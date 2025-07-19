{
  description = "Karan's Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
    let
      system = "aarch64-darwin"; # or "x86_64-linux" for Linux
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Development shells per system
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Core development tools
          git
          curl
          wget
          tree
          ripgrep
          fd
          fzf
          bat
          eza
          zoxide
          
          # Neovim with dependencies
          neovim
          nodejs_20
          python3
          lua
          luarocks
          
          # Language servers and tools
          lua-language-server
          nil # Nix LSP
          nodePackages.typescript-language-server
          nodePackages.prettier
          nodePackages.eslint
          
          # Shell tools
          zsh
          oh-my-zsh
          starship
          
          # Build tools
          gnumake
          cmake
          gcc
        ];

        shellHook = ''
          echo "🚀 Development environment loaded!"
          echo "Neovim config: ~/.config/nvim"
          echo "Run 'nvim' to start editing"
        '';
      };

      # Home Manager configuration at top level
      homeConfigurations.karanjanthe = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username = "karanjanthe";
            home.homeDirectory = "/Users/karanjanthe";
            home.stateVersion = "23.11";

            # Programs configuration
            programs = {
              home-manager.enable = true;
              
              # Git configuration
              git = {
                enable = true;
                userName = "karanjanthe";
                userEmail = "karanjanthe@gmail.com";
              };

              # Zsh configuration
              zsh = {
                enable = true;
                enableCompletion = true;
                autosuggestion.enable = true;
                syntaxHighlighting.enable = true;
                
                shellAliases = {
                  ll = "eza -la";
                  ls = "eza";
                  cat = "bat";
                  find = "fd";
                  grep = "rg";
                  cd = "z";
                };

                oh-my-zsh = {
                  enable = true;
                  plugins = [ 
                    "git" 
                    "docker" 
                    "kubectl" 
                    "node" 
                    "npm" 
                    "yarn"
                    "z"
                  ];
                  theme = "robbyrussell";
                };

                initContent = ''
                  # Custom zsh configuration
                  export EDITOR=nvim
                  export VISUAL=nvim
                  
                  # Zoxide setup
                  eval "$(zoxide init zsh)"
                  
                  # Starship prompt (optional)
                  # eval "$(starship init zsh)"
                '';
              };

              # Starship prompt
              starship = {
                enable = true;
                enableZshIntegration = true;
              };

              # Modern shell tools
              bat.enable = true;
              eza.enable = true;
              fzf.enable = true;
              zoxide.enable = true;
            };

            # Symlink Neovim configuration
            home.file.".config/nvim".source = ./.;
          }
        ];
      };
    };
}