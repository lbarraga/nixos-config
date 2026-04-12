{den, ...}: {
  den.aspects.monitoring = {
    # The exporter relies on the mesh network to be safely exposed
    includes = [den.aspects.netbird-client];

    nixos = {config, ...}: {
      services.prometheus.exporters.node = {
        enable = true;
        port = 9100;
      };

      # Dynamically query the NetBird interface name and the exporter port
      networking.firewall.interfaces.${config.services.netbird.clients.default.interface}.allowedTCPPorts = [
        config.services.prometheus.exporters.node.port
      ];
    };
  };
}
