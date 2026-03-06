{ inputs, ... }:

{
  flake.modules.nixos.personal = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.personal ];
  };

  flake.modules.homeManager.personal = { pkgs, ... }: {
    home.packages = with pkgs; [
      spotify
      discord
      obsidian
      synology-drive-client
      anki
    ];
  };
}
