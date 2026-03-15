{
  den.aspects.user-guest = {
    nixos.users.users.guest = {
      isNormalUser = true;
      description = "Guest User";
      extraGroups = [
        "networkmanager"
        "video"
        "audio"
      ];
      initialPassword = "nixos";
    };
    homeManager.home.stateVersion = "25.05";
  };
}
