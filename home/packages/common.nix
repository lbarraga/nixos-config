{ pkgs, unstable_pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    btop
    killall
    tree
    neofetch
    gcc
    nodejs_20
    unzip
    gthumb
    adwaita-icon-theme
    networkmanagerapplet
    udiskie
    orca-slicer
    xournalpp
    anki
    libreoffice
    sops

    starship
    cava
    vlc

    obsidian
    stremio
    spotify
    discord
    synology-drive-client

    pavucontrol
    qpwgraph

    unstable_pkgs.pangolin-cli

  ];
}
