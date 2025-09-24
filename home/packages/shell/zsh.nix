{ nixosConfig, ... }: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nix-shell = "nix-shell --run zsh";
      rebuild =
        "sudo nixos-rebuild switch --flake ~/nix-config#${nixosConfig.my.host.hostname}";
      ls = "eza";
      ll = "eza -lah";
      lt = "eza --tree"; # Tree view
      edit = "xournalpp";
    };

    initContent = ''
      eval "$(starship init zsh)"
      zstyle ':completion:*' menu select
    '';

  };

}
