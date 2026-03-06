{
  flake.modules.nixos.guest = { config, ... }: {

    users.users.guest = {
      isNormalUser = true;
      description = "Guest User";
      extraGroups = [ "networkmanager" "video" "audio" ];
      initialPassword = "nixos";
    };

    home-manager.users.guest = { pkgs, ... }: { home.stateVersion = "25.05"; };
  };
}
