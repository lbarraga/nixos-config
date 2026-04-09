{
  den.aspects.battery-protection = {
    nixos = {
      services.tlp = {
        enable = true;
        settings = {
          START_CHARGE_THRESH_BAT1 = 70; # Starts charging when it falls below this
          STOP_CHARGE_THRESH_BAT1 = 80; # Stops charging when it reaches this
        };
      };
    };
  };
}
