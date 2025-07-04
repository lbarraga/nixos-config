{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    htop
    btop
    killall
    tree
    vim
    neofetch

    adwaita-icon-theme

    brave
    stremio
    spotify
    discord
    synology-drive-client
    kdePackages.kate

  ];
}
