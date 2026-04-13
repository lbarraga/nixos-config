{
  den,
  lib,
  inputs,
  ...
}: {
  den.aspects.monitoring-hub = {
    # The monitoring server also needs to export its own metrics
    includes = [den.aspects.monitoring];

    nixos = {config, ...}: let
      # 1. Introspect the global flake configurations
      allHosts = inputs.self.nixosConfigurations;

      # 2. Filter the entire fleet down to ONLY hosts where the node exporter is enabled
      exporterHosts =
        lib.filterAttrs (
          hostname: hostConfig:
            hostConfig.config.services.prometheus.exporters.node.enable
        )
        allHosts;

      # 3. Transform the filtered host configurations into the ["hostname:port"] array
      dynamicTargets =
        lib.mapAttrsToList (
          hostname: hostConfig: "${hostname}:${toString hostConfig.config.services.prometheus.exporters.node.port}"
        )
        exporterHosts;
    in {
      services.prometheus = {
        enable = true;
        port = 9090;
        scrapeConfigs = [
          {
            job_name = "dendritic-mesh-nodes";
            static_configs = [
              {
                # Inject the dynamically generated list of targets
                targets = dynamicTargets;
              }
            ];
          }
        ];
      };

      services.grafana = {
        enable = true;
        settings.server = {
          http_port = 5000;
          http_addr = "0.0.0.0";
        };

        provision = {
          enable = true;

          dashboards.settings.providers = [
            {
              name = "Dendritic Dashboards";
              options.path = ../config/grafana/mesh-overview.json;
            }
          ];

          # Automatically wire Prometheus into Grafana
          datasources.settings.datasources = [
            {
              name = "Prometheus";
              type = "prometheus";
              access = "proxy";
              url = "http://127.0.0.1:${toString config.services.prometheus.port}";
              isDefault = true;
            }
          ];
        };
      };

      # Open Grafana strictly over the NetBird interface
      networking.firewall.interfaces.${config.services.netbird.clients.default.interface}.allowedTCPPorts = [
        config.services.grafana.settings.server.http_port
      ];
    };
  };
}
