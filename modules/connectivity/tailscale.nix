{
  flake.modules.nixos.tailscale = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.tailscale ];
    services.tailscale.enable = false;
  };
}
