{ config, pkgs, settings, ... }:

{

  programs.zsh.enable = true;

  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.userFullName;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;
}
