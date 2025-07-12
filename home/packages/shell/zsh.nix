{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nix-shell = "nix-shell --run zsh";
      ls = "eza";
      ll = "eza -lah";
      lt = "eza --tree"; # Tree view
    };

    initContent = ''
      eval "$(starship init zsh)"
      zstyle ':completion:*' menu select
    '';

  };

}
