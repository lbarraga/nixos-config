{ pkgs, ... }:

{
  home.username = "lukasbt";
  home.homeDirectory = "/home/lukasbt";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
