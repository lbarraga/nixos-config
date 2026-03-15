{
  den.aspects.udisks = {
    nixos = {
      # Enable GVFS (GNOME Virtual file system) for trash/mounting support
      services.gvfs.enable = true;

      # Enable the Udisks2 daemon for mounting block devices
      services.udisks2.enable = true;
    };
  };
}
