{ inputs, ... }:

{
  flake.modules.nixos.office = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.office ];
  };

  flake.modules.homeManager.office = { pkgs, ... }: {
    home.packages = with pkgs; [ libreoffice xournalpp vlc gthumb cava ];
  };
}
