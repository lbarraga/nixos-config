{
  den.aspects.immich-server = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {

        nixpkgs.overlays = [
          (final: prev: {
            onnxruntime = prev.onnxruntime.override { cudaSupport = true; };
          })
        ];

        services.immich = {
          enable = true;
          host = "0.0.0.0";
          port = 2283;
          openFirewall = true;

          mediaLocation = "/mnt/hdd/immich";

          machine-learning = {
            enable = true;
            environment.LD_LIBRARY_PATH = lib.mkForce "${pkgs.python3Packages.onnxruntime}/lib";
          };
        };

        systemd.services.immich-machine-learning.serviceConfig = {
          PrivateDevices = lib.mkForce false;
          DeviceAllow = [
            "/dev/nvidia0"
            "/dev/nvidiactl"
            "/dev/nvidia-uvm"
          ];
        };

        users.users.immich.extraGroups = [
          "video"
          "render"
        ];

        systemd.tmpfiles.rules = [
          "d /mnt/hdd/immich 0750 immich immich - -"
        ];
      };
  };
}
