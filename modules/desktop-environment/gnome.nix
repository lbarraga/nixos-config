{
  den.aspects.gnome = {
    nixos = {
      # Enable the X11 windowing system
      services.xserver.enable = true;

      # Enable the GNOME Desktop Environment and GDM display manager
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
    };

    homeManager = {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          font-name = "JetBrainsMono Nerd Font 11";
          document-font-name = "JetBrainsMono Nerd Font 11";
          monospace-font-name = "JetBrainsMono Nerd Font 10";
          titlebar-font = "JetBrainsMono Nerd Font Bold 11";
        };
      };
    };
  };
}
