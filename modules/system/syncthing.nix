{
  flake.modules.nixos.syncthing =
    { config, ... }:
    let
      inherit (config.my) username;

      syncDir = "/home/${username}/sync";
    in
    {
      services.syncthing = {
        enable = true;

        user = username;
        group = "users";

        # Puts the config and the device key in ~/.config/syncthing, where
        # syncthing would have put them itself.
        dataDir = "/home/${username}";

        # TCP/UDP 22000 for transfers, UDP 21027 for discovery on the LAN.
        openDefaultPorts = true;

        settings = {
          devices.vic = {
            id = "KMS77RU-P3ISH3T-IRK4HVT-EB3LFXB-7IVODJF-MIXYRB3-VCMWB7O-Q43G4AN";

            # On the LAN the local announcements find vic on their own. Away
            # from it, global discovery is off, so the name has to be written
            # down. It is the netbird record that already points at vic.
            addresses = [
              "tcp://sync.barragan.party:22000"
              "dynamic"
            ];
          };

          folders.${syncDir} = {
            # Agreed with vic. The path differs per machine, so the id cannot
            # be left to default to it.
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
