{ config, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./packages/common.nix
    ./packages/git.nix
    ./packages/brave-browser.nix
    ./packages/nvim/nvim.nix
    ./packages/gpg/gpg.nix
    ./packages/fonts.nix
    ./packages/shell/zsh.nix
    ./packages/shell/starship.nix
    ./packages/hypr
    ./packages/dev
  ];
}

