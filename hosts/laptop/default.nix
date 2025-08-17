{
  imports = [ ../../nixos/configuration.nix ./hardware-configuration.nix ];

  my.host = {
    hostname = "laptop";

    hyprland = {
      keyboardLayout = "be";
      primaryMonitor = "eDP-1";
      monitors = [ "eDP-1,preferred,0x0,1" ];

      workspaces = { "eDP-1" = [ 1 2 3 4 5 6 7 8 9 10 ]; };
    };
  };

}
