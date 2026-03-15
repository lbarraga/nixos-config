{
  den.aspects.mullvad = {
    nixos =
      { pkgs, ... }:
      {
        services.mullvad-vpn = {
          enable = true;
          package = pkgs.mullvad-vpn;
        };
      };
  };
}
