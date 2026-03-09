{
  flake.modules.nixos.embedded-dev =
    { pkgs, ... }:
    {
      users.groups.plugdev = { };
      users.users.lukasbt.extraGroups = [ "plugdev" ];

      services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="0660", GROUP="users", TAG+="uaccess"
      '';
    };
}
