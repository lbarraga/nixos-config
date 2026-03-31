{den, ...}: {
  den.hosts.x86_64-linux.laptop.users.lukasbt = {};

  den.aspects.laptop = {
    includes = with den.aspects; [
      workstation
      virtualbox
    ];

    nixos = {
      imports = [./_hardware-configuration.nix];
      networking.hostName = "laptop";
    };
  };
}
