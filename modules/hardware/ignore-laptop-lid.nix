{
  den.aspects.ignore-laptop-lid = {
    nixos.services.logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
      powerKey = "ignore";
    };
  };
}
