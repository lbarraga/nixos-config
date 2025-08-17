{ lib, ... }:

{
  options.my.host = {

    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the machine.";
    };

    hyprland = {
      keyboardLayout = lib.mkOption {
        type = lib.types.str;
        description = "Keyboard layout for Hyprland (e.g., 'us' or 'be').";
      };

      primaryMonitor = lib.mkOption {
        type = lib.types.str;
        description = "The name of the primary monitor for wallpaper.";
      };

      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "The 'monitor=' lines for hyprland.conf.";
      };

      workspaces = lib.mkOption {
        type = lib.types.attrsOf (lib.types.listOf lib.types.int);
        description =
          "Hyprland workspaces grouped by monitor, e.g., { DP-1 = [1 2 3]; DP-2 = [4 5 6 7]; HDMI-A-1 = [8 9 10]; }";
      };
    };
  };
}
