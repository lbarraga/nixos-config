{
  imports = [ ../../nixos/configuration.nix ./hardware-configuration.nix ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

}
