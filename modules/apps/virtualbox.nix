{
  den.aspects.virtualbox = {
    nixos = {
      virtualisation.virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };
        guest = {
          enable = true;
          dragAndDrop = true;
        };
      };

      # Adding your user to the vboxusers group
      users.users.lukasbt.extraGroups = ["vboxusers"];
    };
  };
}
