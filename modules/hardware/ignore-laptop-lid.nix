{
  flake.modules.nixos.ignore-laptop-lid = {
    services.logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
      powerKey = "ignore";
    };
  };
}
