{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
    gvfs # needed for mounting, trash, etc.
    udisks2 # backend for mounts
  ];
}

