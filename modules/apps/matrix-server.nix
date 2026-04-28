{den, ...}: {
  den.aspects.matrix-server = {
    includes = [den.aspects.netbird-client];
    nixos = {config, ...}: {
      services.matrix-conduit = {
        enable = true;
        settings.global = {
          server_name = config.networking.hostName;
          allow_registration = true;
        };
      };

      networking.firewall.interfaces.${config.services.netbird.clients.default.interface}.allowedTCPPorts = [
        6167
      ];
    };
  };
}
