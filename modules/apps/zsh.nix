{den, ...}: {
  den.aspects.zsh = {
    includes = [den.aspects.starship];

    nixos = {pkgs, ...}: {
      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
    };

    homeManager = {osConfig, ...}: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          nix-shell = "nix-shell --run zsh";
          ls = "eza";
          ll = "eza -lah";
          lt = "eza --tree";
          edit = "xournalpp";
          open = "xdg-open";
          temp = "cd \"$(mktemp -d)\"";
        };

        initContent = ''
          zstyle ':completion:*' menu select

          bindkey '\e[1;5D' backward-word
          bindkey '\e[1;5C' forward-word
          bindkey '^o' autosuggest-accept
          bindkey '^k' up-line-or-history
          bindkey '^j' down-line-or-history
        '';
      };

      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
        enableZshIntegration = true;
      };
    };
  };
}
