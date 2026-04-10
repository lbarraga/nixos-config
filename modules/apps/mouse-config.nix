{
  den.aspects.mouse-config = {
    nixos = {pkgs, ...}: {
      services.ratbagd.enable = true;
      environment.systemPackages = [pkgs.piper];
    };
  };
}
