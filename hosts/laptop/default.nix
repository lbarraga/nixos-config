{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/default.nix
    ./hardware-configuration.nix
  ];
}
