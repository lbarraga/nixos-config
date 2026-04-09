{
  den.aspects.monitoring = {
    nixos =
      { config, ... }:
      {

        services.grafana = {
          enable = true;
          settings.server = {
            http_port = 5000;
            http_addr = "0.0.0.0";
          };

          provision = {
            enable = true;
            datasources.settings.datasources = [
              {
                name = "Prometheus";
                type = "prometheus";
                access = "proxy";
                url = "http://127.0.0.1:9090";
                isDefault = true;
              }
            ];
          };
        };

        services.prometheus = {
          enable = true;
          port = 9090;

          scrapeConfigs = [
            {
              job_name = "nixos-server";
              static_configs = [
                {
                  targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
                }
              ];
            }
          ];
        };

        services.prometheus.exporters.node = {
          enable = true;
          port = 9100;
          enabledCollectors = [ "systemd" ];
        };

        networking.firewall.allowedTCPPorts = [ 5000 ];
      };
  };
}
