{ inputs, ... }:

{
  flake.modules.nixos.laptop = {

    imports = [
      inputs.self.modules.nixos.lukas-desktop # The exact same bundle as the desktop!
      ./_hardware-configuration.nix # The laptop's specific hardware
    ];

    networking.hostName = "laptop";

    my.host = {
      defaultUser = "lukasbt";
      hyprland = {
        keyboardLayout = "be";
        primaryMonitor = "eDP-1";
        monitors = [ "eDP-1,preferred,0x0,1" ];
        workspaces = { "eDP-1" = [ 1 2 3 4 5 6 7 8 9 10 ]; };
      };
    };
  };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "laptop";
}
