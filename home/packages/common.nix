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
    ripgrep
    gthumb
    adwaita-icon-theme
    networkmanagerapplet
    
    starship
    cava
    vlc
    
    obsidian
    stremio
    spotify
    discord
    synology-drive-client
    
  ];
}
