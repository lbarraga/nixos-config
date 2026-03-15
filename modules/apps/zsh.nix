{
  den.aspects.zsh = {
    nixos =
      { pkgs, ... }:
      {
        programs.zsh.enable = true;
        users.defaultUserShell = pkgs.zsh;
      };

    homeManager =
      { osConfig, ... }:
      {
        programs.starship.enable = true;
        home.file.".config/starship.toml".source = ./starship.toml;

        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          shellAliases = {
            nix-shell = "nix-shell --run zsh";
            rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#${osConfig.networking.hostName}";
            ls = "eza";
            ll = "eza -lah";
            lt = "eza --tree";
            edit = "xournalpp";
            open = "xdg-open";
          };

          initContent = ''
            eval "$(starship init zsh)"
            zstyle ':completion:*' menu select

            bindkey '\e[1;5D' backward-word
            bindkey '\e[1;5C' forward-word
          '';
        };
      };
  };
}
