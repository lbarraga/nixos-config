{ inputs, ... }:

{
  flake.modules.nixos.nvim = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.nvim ];
  };

  flake.modules.homeManager.nvim =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        extraPackages = with pkgs; [
          # --- LAZYVIM REQUIREMENTS ---

          # Git (Nixpkgs git is always > 2.19.0)
          git

          # UI & Workflow
          lazygit

          # Tree-sitter core & compilers
          tree-sitter
          gcc
          gnumake

          # Blink.cmp completion engine
          curl

          # FZF-Lua requirements
          fzf
          ripgrep # for live grep
          fd # for find files

          # Clipboard provider for Wayland (needed to yank/paste to system clipboard in Hyprland)
          wl-clipboard

          # Mason.nvim dependencies (used by LazyVim to download LSPs/formatters)
          nodejs # Required by Pyright, TSServer, BashLS, etc.
          python3 # Required by some Mason packages
          cargo # Required by Rust-based tools
          unzip # Required by Mason to extract downloaded archives
          wget # Fallback downloader for Mason
        ];
      };
    };
}
