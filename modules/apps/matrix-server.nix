{den, ...}: {
  den.aspects.matrix-server = {
    includes = [den.aspects.netbird-client];
    nixos = {config, ...}: {
      services.matrix-conduit = {
        enable = true;
        settings.global = {
          server_name = config.networking.hostName;
          allow_registration = true;
          address = "0.0.0.0";
          port = 6167;
        };
      };

      networking.firewall.interfaces.${config.services.netbird.clients.default.interface}.allowedTCPPorts = [
        6167
      ];
    };
  };
}
