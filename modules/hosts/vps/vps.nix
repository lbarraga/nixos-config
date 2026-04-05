{den, ...}: {
  den.hosts.x86_64-linux.vps.users.lukasbt = {};

  den.aspects.vps = {
    includes = with den.aspects; [
      # boot
      boot-legacy
      core
      ssh-server
      tailscale
      cli-tools
      git
      nvim
      zsh
      nh
      docker

      # New services
      # pangolin
      minecraft-server
    ];

    nixos = {
      imports = [./_hardware-configuration.nix];
      networking.hostName = "vps";

      services.qemuGuest.enable = true;
    };
  };
}
