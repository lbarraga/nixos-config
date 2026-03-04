{ config, ... }:

{
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";

    defaultSopsFile = ../../hosts/${config.my.host.hostname}/secrets.yaml;
    defaultSopsFormat = "yaml";
  };
}
