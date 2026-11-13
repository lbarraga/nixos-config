{
  flake.modules.nixos.syncthing =
    { config, pkgs, ... }:
    let
      inherit (config.my) username;

      syncDir = "/home/${username}/sync";
    in
    {
      services.syncthing = {
        enable = true;

        user = username;
        group = "users";

        # Puts the config and the device key in ~/.config/syncthing, which is
        # also where syncthingtray looks for the api key.
        dataDir = "/home/${username}";

        openDefaultPorts = true;

        settings = {
          devices.vic = {
            id = "KMS77RU-P3ISH3T-IRK4HVT-EB3LFXB-7IVODJF-MIXYRB3-VCMWB7O-Q43G4AN";

            # Local announcements find vic on the LAN. Away from it, global
            # discovery is off, so the netbird name has to be written down.
            addresses = [
              "tcp://sync.barragan.party:22000"
              "dynamic"
            ];
          };

          # Agreed with vic; the path differs per machine.
          folders.${syncDir} = {
            id = "sync";
            label = "sync";
            devices = [ "vic" ];
          };

          options = {
            globalAnnounceEnabled = false;
            relaysEnabled = false;
            natEnabled = false;

            urAccepted = -1;
          };
        };
      };

      # Syncthing makes a folder and its .stfolder marker together, and
      # refuses a folder that exists without one.
      systemd.tmpfiles.settings."10-syncthing" = {
        ${syncDir}.d = {
          user = username;
          group = "users";
          mode = "0755";
        };

        "${syncDir}/.stfolder".d = {
          user = username;
          group = "users";
          mode = "0755";
        };
      };
    };
}
