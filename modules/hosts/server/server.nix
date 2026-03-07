{ inputs, ... }:

{
  flake.modules.nixos.server = {
    imports = with inputs.self.modules.nixos; [
      core
      lukasbt
      nvidia
      ssh-server
      ./_hardware-configuration.nix
    ];

    networking.hostName = "server";
  };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "server";
}
