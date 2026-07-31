{
  den.aspects.freecad = {
    nixos = {pkgs, ...}: {
      programs.dconf.enable = true;

      environment.systemPackages = with pkgs; [
        freecad
        glib
        gtk3
      ];

      # Explicitly force the GTK3 schemas into the global XDG_DATA_DIRS
      environment.extraInit = ''
        export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      '';
    };
  };
}
