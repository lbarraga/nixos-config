{ den, ... }:
{
  den.hosts.x86_64-linux.server.users.lukasbt = { };

  den.aspects.server = {
    includes = with den.aspects; [
      core
      nvidia
      ignore-laptop-lid
      ssh-server
      tailscale
    ];

    nixos = {
      imports = [ ./_hardware-configuration.nix ];
      networking.hostName = "server";
    };
  };
}
