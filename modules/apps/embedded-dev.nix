{
  den.aspects.embedded-dev = {
    nixos =
      { user, ... }:
      {
        users.groups.plugdev = { };
        services.udev.extraRules = ''
          SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="0660", GROUP="users", TAG+="uaccess"
        '';
      };

    user = {
      extraGroups = [ "plugdev" ];
    };
  };
}
