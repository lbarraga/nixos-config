let
  myExtensions = pkgs:
    with pkgs.gnomeExtensions; [
      appindicator
      gnome-40-ui-improvements
      blur-my-shell
      just-perfection
      space-bar
      launch-new-instance
      status-area-horizontal-spacing
      user-themes
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
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disabled-extensions = [];
          enabled-extensions = map (ext: ext.extensionUuid) (myExtensions pkgs);
        };

        "org/gnome/shell/extensions/just-perfection" = {
          dash = false;
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = false;
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 9;
          audible-bell = false;
        };

        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [];
          switch-to-application-2 = [];
          switch-to-application-3 = [];
          switch-to-application-4 = [];
          switch-to-application-5 = [];
          switch-to-application-6 = [];
          switch-to-application-7 = [];
          switch-to-application-8 = [];
          switch-to-application-9 = [];
        };

        "org/gnome/shell/extensions/space-bar/behavior" = {
          show-empty-workspaces = false;
          toggle-overview = false;
        };

        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<Super>5"];
          switch-to-workspace-6 = ["<Super>6"];
          switch-to-workspace-7 = ["<Super>7"];
          switch-to-workspace-8 = ["<Super>8"];
          switch-to-workspace-9 = ["<Super>9"];

          close = ["<Super>q"];
        };
      };
    };
  };
}
