{ inputs, ... }: {

  flake.modules.nixos.desktop = {

    imports = with inputs.self.modules.nixos;
      [
        core
        hyprland
        tailscale
        nvidia
        lukasbt # Me! :D
      ] ++ [ ./hardware-configuration.nix ];

    my.host.hostname = "desktop";
  };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "desktop";
}
