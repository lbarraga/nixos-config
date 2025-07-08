{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -alh";
      nix-shell = "nix-shell --run zsh";
    };

    initContent = ''
    eval "$(starship init zsh)"
    zstyle ':completion:*' menu select
    '';

  };

}
