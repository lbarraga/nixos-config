{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    htop
    btop
    killall
    tree
    neofetch
    gcc
    nodejs_20
    unzip
    xclip
    ripgrep
    gthumb
    adwaita-icon-theme

    brave
    stremio
    spotify
    discord
    synology-drive-client
    
  ];
}
