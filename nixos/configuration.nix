{
  imports = [
    ./modules/users.nix
    ./modules/bootloader.nix
    ./modules/sound.nix
    ./modules/system.nix
    ./modules/bluetooth.nix
    ./modules/packages/udisks.nix
    ./modules/desktop/hyprland.nix
    ./modules/packages/tailscale.nix
    ./modules/packages/steam.nix
  ];
}
