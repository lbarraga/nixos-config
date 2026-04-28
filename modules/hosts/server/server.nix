{ den, ... }:
{
  den.hosts.x86_64-linux.server.users.lukasbt = { };

  den.aspects.server = {
    includes = with den.aspects; [
      # boot
      boot-uefi

      core

      # hardware
      nvidia
      ignore-laptop-lid
      battery-protection

      # connectivity
      ssh-server
      netbird-client

      # cli
      cli-tools
      git
      nh
      nvim
      zsh

      # services
      docker
      monitoring
      monitoring-hub
    ];

    nix.settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };

    nixos = {
      imports = [ ./_hardware-configuration.nix ];
      networking.hostName = "server";
    };
  };
}
