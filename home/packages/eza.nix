{ config, pkgs, ... }:

{
  # A modern ls alternative
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    enableZshIntegration = true;
  };
}
