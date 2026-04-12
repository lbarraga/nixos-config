{den, ...}: {
  den.hosts.x86_64-linux.vps.users.lukasbt = {};

  den.aspects.vps = {
    includes = with den.aspects; [
      # boot
      boot-legacy
      core
      ssh-server
      # tailscale
      netbird-client
      cli-tools
      git
      nvim
      zsh
      nh
      docker

      # New services
      minecraft-server
      monitoring
    ];

    nixos = {
      imports = [./_hardware-configuration.nix];
      networking.hostName = "vps";

      services.qemuGuest.enable = true;
    };
  };
}
