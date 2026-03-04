{ inputs, ... }:

{
  flake.modules.nixos.lukasbt = {
    users.users.lukasbt = {
      isNormalUser = true;
      description = "Lukas Barragan Torres";
      extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" ];
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";

      users.lukasbt = {
        imports = [ inputs.self.modules.homeManager.lukasbt ];
      };
    };
  };

  flake.modules.homeManager.lukasbt = {
    home.username = "lukasbt";
    home.homeDirectory = "/home/lukasbt";

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
  };
}
