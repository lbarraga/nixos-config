{
  den.aspects.system-tray = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          networkmanagerapplet
          udiskie
          pavucontrol
          qpwgraph
        ];
      };
  };
}
