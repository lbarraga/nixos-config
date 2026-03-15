{den, ...}: {
  # 1. Register the VM and assign the "guest" user to it
  den.hosts.x86_64-linux.vm.users.guest = {};

  den.aspects.vm = {
    # 2. Include the shared graphical role
    includes = with den.aspects; [
      workstation
    ];

    # 3. VM-specific NixOS settings and QEMU optimizations
    nixos = {modulesPath, ...}: {
      imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      networking.hostName = "vm";

      # SPICE support for better VM interaction
      services.spice-vdagentd.enable = true;
      boot.loader.grub.gfxmodeBios = "1920x1080";

      virtualisation.vmVariant = {
        virtualisation.qemu.options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
        ];
        virtualisation.diskSize = 20480;
        virtualisation.memorySize = 4096;
        virtualisation.cores = 4;
      };
    };
  };
}
