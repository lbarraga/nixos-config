{
  den.aspects.office = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
        xournalpp
        vlc
        gthumb
        cava
      ];
    };
  };
}
