{
  flake.modules.nixos.embedded-dev =
    { pkgs, ... }:
    {
      users.groups.plugdev = { };
      users.users.lukasbt.extraGroups = [ "plugdev" ];
    };
}
