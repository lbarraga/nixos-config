{ config, unstable_pkgs, pkgs, ... }:

{
  environment.systemPackages = [ unstable_pkgs.fosrl-olm ];

  networking.firewall = { trustedInterfaces = [ "olm" ]; };

  sops.secrets."olm_env" = { restartUnits = [ "olm.service" ]; };

  systemd.services.olm = {
    description = "Olm Tunneling Client";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart =
        "${unstable_pkgs.fosrl-olm}/bin/olm --override-dns --tunnel-dns";
      EnvironmentFile = config.sops.secrets."olm_env".path;

      Restart = "always";
      RestartSec = "5s";
      User = "root";
    };
  };
}
