{ config, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./packages/common.nix
    ./packages/git.nix
    ./packages/nvim/nvim.nix
    ./packages/gpg/gpg.nix
    ./packages/fonts.nix
    ./packages/shell/zsh.nix
    ./packages/hypr
  ];
}

