{ inputs, ... }: {
  flake.modules.nixos.vm = { config, lib, pkgs, modulesPath, ... }: {
    imports = with inputs.self.modules.nixos; [
      public-desktop
      guest

      # standard NixOS QEMU guest optimizations
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    networking.hostName = "vm";

    my.host = {
      defaultUser = "guest";
      hyprland = {
        keyboardLayout = "us";
        primaryMonitor = "Virtual-1"; # Belangrijk voor QEMU
        monitors = [ "Virtual-1,1920x1080@60,0x0,1" ];
        workspaces = { "Virtual-1" = [ 1 2 3 4 5 6 7 8 9 10 ]; };
      };
    };

    environment.variables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };

    services.spice-vdagentd.enable = true;

    boot.loader.grub.gfxmodeBios = "1920x1080";

    virtualisation.vmVariant = {
      virtualisation.qemu.options =
        [ "-device virtio-vga-gl" "-display gtk,gl=on" ];
      virtualisation.diskSize = 20480;
      virtualisation.memorySize = 4096;
      virtualisation.cores = 4;
    };
  };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "vm";

}
