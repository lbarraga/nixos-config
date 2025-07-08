{ pkgs, settings, ... }:

{
  home.username = settings.username; 
  home.homeDirectory = "/home/${settings.username}";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
