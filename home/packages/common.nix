{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    htop
    btop
    killall
    tree
    neofetch
    gcc

    adwaita-icon-theme

    brave
    stremio
    spotify
    discord
    synology-drive-client
    
  ];
}
