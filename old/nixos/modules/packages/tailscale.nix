{ pkgs, ... }:

{

  # https://tailscale.com/kb/1096/nixos-minecraft?q=nix

  # make the tailscale command usable to users
  environment.systemPackages = [ pkgs.tailscale ];

  # enable the tailscale service
  services.tailscale.enable = false;
}
