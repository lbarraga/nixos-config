{
  den.aspects.gnome = {
    nixos = {pkgs, ...}: {
      services.xserver.enable = true;

      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      # dont want this
      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        epiphany # web browser
        geary # email reader
      ];

      environment.systemPackages = with pkgs; [
        gnome-tweaks
        gnomeExtensions.dash-to-dock
        gnomeExtensions.appindicator
      ];
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
