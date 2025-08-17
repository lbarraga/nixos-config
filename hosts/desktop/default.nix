{ config, ... }: {
  imports = [ ../../nixos/configuration.nix ./hardware-configuration.nix ];

  my.host = {

    hostname = "desktop";

    hyprland = {
      keyboardLayout = "us";
      primaryMonitor = "DP-2";
      monitors = [
        "DP-2,preferred,0x0,1"
        "DP-1,preferred,auto-left,1"
        "HDMI-A-1,1920x1080@144,auto-right,1"
      ];

      workspaces = {
        "DP-1" = [ 1 2 3 ];
        "DP-2" = [ 4 5 6 7 ];
        "HDMI-A-1" = [ 8 9 10 ];
      };

    };

  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable OpenGL
  hardware.graphics = { enable = true; };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
