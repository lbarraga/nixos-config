{ den, ... }:
{
  den.aspects.matrix-server = {
    includes = [ den.aspects.netbird-client ];
    nixos =
      { config, pkgs, ... }:
      {

        security.acme = {
          acceptTerms = true;
          defaults.email = "lukas.barragantorres@ugent.be";
        };

        services.coturn = {
          enable = true;
          no-cli = true;
          use-auth-secret = true;
          static-auth-secret = "change-this-to-a-random-secure-string";
          realm = "matrix.barragan.cloud";
          listening-ips = [ "0.0.0.0" ];
          extraConfig = ''
            min-port=49152
            max-port=65535
          '';
        };

        services.matrix-conduit = {
          enable = true;
          settings.global = {
            server_name = "matrix.barragan.cloud";
            allow_registration = true;
            address = "127.0.0.1";
            port = 6167;

            turn_uris = [
              "turn:matrix.barragan.cloud:3478?transport=udp"
              "turn:matrix.barragan.cloud:3478?transport=tcp"
            ];
            turn_secret = "change-this-to-a-random-secure-string";
          };
        };

        services.nginx = {
          enable = true;
          recommendedProxySettings = true;
          recommendedTlsSettings = true;

          virtualHosts."matrix.barragan.cloud" = {
            forceSSL = true;
            enableACME = true;

            locations."/_matrix" = {
              proxyPass = "http://127.0.0.1:6167";
              proxyWebsockets = true;
            };

            locations."/.well-known/matrix" = {
              proxyPass = "http://127.0.0.1:6167";
            };
          };

          virtualHosts."chat.barragan.cloud" = {
            forceSSL = true;
            enableACME = true;

            root = pkgs.element-web.override {
              conf = {
                default_server_config = {
                  "m.homeserver" = {
                    "base_url" = "https://matrix.barragan.cloud";
                    "server_name" = "matrix.barragan.cloud";
                  };
                };
              };
            };
          };
        };

        networking.firewall.allowedTCPPorts = [
          80
          443 # Nginx (HTTP and HTTPS)
          3478 # Coturn TCP
        ];

        networking.firewall.allowedUDPPorts = [
          3478 # Coturn UDP
        ];

        networking.firewall.allowedUDPPortRanges = [
          {
            from = 49152;
            to = 65535;
          } # Coturn relay ports
        ];
      };
  };
}
