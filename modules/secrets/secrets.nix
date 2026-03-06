{ inputs, ... }:

{
  flake.modules.nixos.secrets = { config, ... }: {
    sops = {
      age.keyFile = "/var/lib/sops-nix/key.txt";
      # Dynamically point to the host's secrets.yaml
      defaultSopsFile =
        "${inputs.self}/modules/hosts/${config.networking.hostName}/secrets.yaml";
      defaultSopsFormat = "yaml";
    };
  };
}
