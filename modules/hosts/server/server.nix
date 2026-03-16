{ den, ... }:
{
  den.hosts.x86_64-linux.server.users.lukasbt = { };

  den.aspects.server = {
    includes = with den.aspects; [
      core

      # hardware
      nvidia
      ignore-laptop-lid

      # connectivity
      ssh-server
      tailscale

      # cli
      cli-tools
      nh
      nvim
      zsh
    ];

    nixos = {
      imports = [ ./_hardware-configuration.nix ];
      networking.hostName = "server";
    };
  };
}
