{
  den.aspects.tailscale = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.tailscale ];
        services.tailscale.enable = false;
      };
  };
}
