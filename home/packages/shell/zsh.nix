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
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    zstyle ':completion:*' menu select
    '';

    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        file = "p10k.zsh";
        name = "powerlevel10k-config";
        src = ./p10k.zsh;
      }
    ];
  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];
}
