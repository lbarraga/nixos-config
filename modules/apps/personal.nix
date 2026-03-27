{
  den.aspects.personal = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        spotify
        discord
        obsidian
        synology-drive-client
        anki
      ];

      systemd.user.services.synology-drive = {
        Unit = {
          Description = "Synology Drive Client Autostart";
          After = ["graphical-session.target"];
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
        Service = {
          ExecStart = "${pkgs.synology-drive-client}/bin/synology-drive";
          Restart = "on-failure";
        };
      };
    };
  };
}
