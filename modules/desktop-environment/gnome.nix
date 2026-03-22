let
  myExtensions = pkgs:
    with pkgs.gnomeExtensions; [
      appindicator
      gnome-40-ui-improvements
      blur-my-shell
      dash-to-dock
      just-perfection
    ];
in {
  den.aspects.gnome = {
    nixos = {pkgs, ...}: {
      services.xserver.enable = true;
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        epiphany
        geary
      ];

      environment.systemPackages =
        [
          pkgs.gnome-tweaks
        ]
        ++ (myExtensions pkgs);
    };

    homeManager = {pkgs, ...}: {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          font-name = "JetBrainsMono Nerd Font 11";
          document-font-name = "JetBrainsMono Nerd Font 11";
          monospace-font-name = "JetBrainsMono Nerd Font 10";
          titlebar-font = "JetBrainsMono Nerd Font Bold 11";
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disabled-extensions = [];
          enabled-extensions = map (ext: ext.extensionUuid) (myExtensions pkgs);
        };

        "org/gnome/shell/extensions/just-perfection" = {
          dash = false;
        };
      };
    };
  };
}
