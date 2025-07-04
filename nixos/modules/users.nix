{ config, pkgs, ... }:

{

  programs.zsh.enable = true;

  users.users.lukasbt = {
    isNormalUser = true;
    description = "Lukas Barragan Torres";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;
}
