{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/default.nix
    ./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

}
