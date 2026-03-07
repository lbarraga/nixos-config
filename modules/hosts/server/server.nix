{ inputs, ... }:

{
  flake.modules.nixos.server = {
    imports = with inputs.self.modules.nixos; [
      # Base System
      core
      ./_hardware-configuration.nix

      # Hardware
      nvidia

      # Connectivity
      ssh-server
      # tailscale

      # User & Apps
      lukasbt
      shell
      cli-tools
      git
      nvim
    ];

    networking.hostName = "server";
  };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "server";
}
