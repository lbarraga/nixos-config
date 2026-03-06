{ inputs, ... }:

{
  flake.modules.nixos.system-tray = {
    home-manager.sharedModules =
      [ inputs.self.modules.homeManager.system-tray ];
  };

  flake.modules.homeManager.system-tray = { pkgs, ... }: {
    home.packages = with pkgs; [
      networkmanagerapplet
      udiskie
      pavucontrol
      qpwgraph
    ];
  };
}
