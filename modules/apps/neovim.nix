{
  den.aspects.nvim = {
    homeManager =
      { pkgs, ... }:
      {
        programs.neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;

          extraPackages = with pkgs; [
            # --- LAZYVIM REQUIREMENTS ---
            git
            lazygit
            tree-sitter
            gcc
            gnumake
            curl
            fzf
            ripgrep
            fd
            wl-clipboard
            nodejs
            python3
            cargo
            unzip
            wget
          ];
        };
      };
  };
}
