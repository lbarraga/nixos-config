{ den, ... }:
{
  den.hosts.x86_64-linux.desktop.users.lukasbt = { };

  den.aspects.desktop = {
    includes = with den.aspects; [
      workstation

      # Desktop-specific hardware & heavy apps
      nvidia
      gaming
      llm
      embedded-dev
    ];

    nixos = {
      imports = [ ./_hardware-configuration.nix ];
      networking.hostName = "desktop";
    };
  };
}
