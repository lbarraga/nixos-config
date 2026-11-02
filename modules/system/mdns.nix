{
  # Resolving <name>.local on the LAN.
  flake.modules.nixos.mdns = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
