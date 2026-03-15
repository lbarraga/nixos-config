{
  den.aspects.gnome = {
    nixos = {
      # Enable the X11 windowing system
      services.xserver.enable = true;

      # Enable the GNOME Desktop Environment and GDM display manager
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
    };
  };
}
