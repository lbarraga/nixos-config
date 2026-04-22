{pkgs, ...}: {
  den.aspects.music-server = {
    nixos = {
      users.groups.media = {};

      users.users.lukasbt.extraGroups = ["media"];

      systemd.tmpfiles.rules = [
        "d /mnt/hdd/music 0770 root media - -"
        "d /mnt/hdd/downloads 0770 root media - -"
      ];

      services.navidrome = {
        enable = true;
        group = "media";
        openFirewall = true;
        settings = {
          Address = "0.0.0.0";
          Port = 4533;
          MusicFolder = "/mnt/hdd/music";
          DataFolder = "/var/lib/navidrome";
          LogLevel = "info";
          ScanSchedule = "@every 5m";
          EnableInsightsCollector = false;
        };
      };

      services.lidarr = {
        enable = true;
        group = "media";
        openFirewall = true;
        dataDir = "/var/lib/lidarr/.config/Lidarr";
      };

      services.prowlarr = {
        enable = true;
        openFirewall = true;
      };

      virtualisation.oci-containers.containers.rdtclient = {
        image = "rogerfar/rdtclient:latest";
        ports = ["6500:6500"];
        volumes = [
          "/var/lib/rdtclient:/data/db"
          "/mnt/hdd/downloads:/data/downloads"
        ];
      };

      networking.firewall.allowedTCPPorts = [6500];

      environment.systemPackages = [pkgs.picard];
    };
  };
}
