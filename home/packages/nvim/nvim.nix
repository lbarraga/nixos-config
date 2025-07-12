{ pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      cargo # for the Nix LSP
      luarocks
      fish # here to make health check have less warnings

      git
      lazygit

      pkg-config
      gcc
      curl
      wget
      fzf
      ripgrep
      fd
    ];
  };

}
