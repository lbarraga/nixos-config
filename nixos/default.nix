{ config, pkgs, ... }:
{
  imports = [
    ./modules/users.nix
    ./modules/bootloader.nix
    ./modules/sound.nix
    ./modules/system.nix
    ./modules/desktop/hyprland.nix
    ./modules/packages/tailscale.nix
  ];
}
