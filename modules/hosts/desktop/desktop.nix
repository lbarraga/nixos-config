{ inputs, ... }:

{
  flake.modules.nixos.desktop = {

    imports =
      with inputs.self.modules.nixos;
      [
        lukas-desktop
        nvidia
        llm
        gaming
      ]
      ++ [ ./_hardware-configuration.nix ];

    networking.hostName = "desktop";

    my.host = {
      defaultUser = "lukasbt";
      hyprland = {
        keyboardLayout = "us";
        primaryMonitor = "DP-2";
        monitors = [
          "DP-2,preferred,0x0,1"
          "DP-1,preferred,auto-left,1"
          "HDMI-A-1,1920x1080@144,auto-right,1"
        ];
        workspaces = {
          "DP-1" = [
            1
            2
            3
          ];
          "DP-2" = [
            4
            5
            6
            7
          ];
          "HDMI-A-1" = [
            8
            9
            10
          ];
        };
      };
    };
  };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "desktop";
}
