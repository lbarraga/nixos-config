{
  den.aspects.personal = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        spotify
        discord
        element
        obsidian
        synology-drive-client
        anki
      ];

      xdg.configFile."autostart/synology-drive.desktop".source = "${pkgs.synology-drive-client}/share/applications/synology-drive.desktop";
    };
  };
}
